package com.nxdeveloper.unmod.core

import android.content.Context
import android.net.Uri
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.channels.awaitClose
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.callbackFlow
import kotlinx.coroutines.launch
import java.io.File
import java.util.Date

/**
 * Drives the full "mod -> source" pipeline: load/download the jar, run [JarDecompiler],
 * zip the result and export it to Downloads, emitting [State] updates along the way.
 */
class DecompileOrchestrator(private val context: Context) {

    sealed class State {
        object Idle : State()

        data class Downloading(val downloaded: Long, val total: Long, val displayName: String) : State()

        data class Loading(val copied: Long, val total: Long, val displayName: String) : State()

        data class Decompiling(val current: Int, val total: Int, val currentClass: String) : State()

        data class Zipping(val current: Int, val total: Int) : State()

        data class Exporting(val displayName: String) : State()

        data class Done(
            val outputUri: Uri,
            val displayPath: String,
            val displayName: String,
            val stats: JarDecompiler.Stats,
            val outputSizeBytes: Long,
        ) : State()

        data class Failed(val stage: String, val message: String) : State()
    }

    fun run(jarUri: Uri): Flow<State> = callbackFlow {
        val cacheRoot = File(context.cacheDir, "uninstaller-work").apply { mkdirs() }
        clearDirectory(cacheRoot)
        val cachedJar = File(cacheRoot, "input.jar")
        val workDir = File(cacheRoot, "decompiled").apply { mkdirs() }

        val job = launch(Dispatchers.IO) {
            trySend(State.Loading(0, 0, ""))
            val loadResult = JarLoader(context).copyToCache(jarUri, cachedJar) { copied, total ->
                trySend(State.Loading(copied, total, ""))
            }
            val picked = loadResult.getOrElse {
                trySend(State.Failed("load", it.message ?: "Unknown load error"))
                close()
                return@launch
            }
            trySend(State.Loading(picked.sizeBytes, picked.sizeBytes, picked.displayName))
            runPipeline(this@callbackFlow, cacheRoot, cachedJar, workDir, picked.displayName)
        }
        awaitClose { job.cancel() }
    }

    fun runFromUrl(downloadUrl: String, displayName: String): Flow<State> = callbackFlow {
        val cacheRoot = File(context.cacheDir, "uninstaller-work").apply { mkdirs() }
        clearDirectory(cacheRoot)
        val cachedJar = File(cacheRoot, "input.jar")
        val workDir = File(cacheRoot, "decompiled").apply { mkdirs() }

        val job = launch(Dispatchers.IO) {
            trySend(State.Downloading(0, 0, displayName))
            val downloadResult = JarDownloader().download(downloadUrl, cachedJar) { downloaded, total ->
                trySend(State.Downloading(downloaded, total, displayName))
            }
            downloadResult.getOrElse {
                trySend(State.Failed("download", it.message ?: "Unknown download error"))
                close()
                return@launch
            }
            runPipeline(this@callbackFlow, cacheRoot, cachedJar, workDir, displayName)
        }
        awaitClose { job.cancel() }
    }

    private suspend fun runPipeline(
        producer: kotlinx.coroutines.channels.ProducerScope<State>,
        cacheRoot: File,
        cachedJar: File,
        workDir: File,
        displayName: String,
    ) {
        producer.trySend(State.Decompiling(0, 0, ""))
        val decompileResult = JarDecompiler().decompile(cachedJar, workDir) { current, total, currentClass ->
            producer.trySend(State.Decompiling(current, total, currentClass))
        }
        val stats = decompileResult.getOrElse {
            producer.trySend(State.Failed("decompile", it.message ?: "Unknown decompile error"))
            return
        }

        writeMetadata(workDir, displayName, stats)
        val zipName = deriveZipName(displayName)
        val outputZip = File(cacheRoot, zipName)

        producer.trySend(State.Zipping(0, 0))
        val zipResult = SourceZipper().zipDirectory(workDir, outputZip) { current, total ->
            producer.trySend(State.Zipping(current, total))
        }
        zipResult.getOrElse {
            producer.trySend(State.Failed("zip", it.message ?: "Unknown zip error"))
            return
        }

        producer.trySend(State.Exporting(zipName))
        val exportResult = DownloadsExporter(context).export(outputZip, zipName)
        val exported = exportResult.getOrElse {
            producer.trySend(State.Failed("export", it.message ?: "Unknown export error"))
            return
        }

        val outputSizeBytes = outputZip.length()
        outputZip.delete()
        clearDirectory(workDir)
        cachedJar.delete()
        producer.trySend(State.Done(exported.uri, exported.displayPath, displayName, stats, outputSizeBytes))
    }

    private fun writeMetadata(outputDir: File, sourceFileName: String, stats: JarDecompiler.Stats) {
        val infoFile = File(outputDir, "NX-UNINSTALLER-INFO.txt")
        val durationSeconds = stats.durationMs / 1000.0
        infoFile.writeText(
            """
                NX Uninstaller
                ==============
                Minecraft Java Uninstaller (mod -> source)

                Source file     : $sourceFileName
                Generated at    : ${Date()}
                Total classes   : ${stats.totalClasses}
                Decompiled OK   : ${stats.decompiled}
                Failed          : ${stats.failed}
                Bundled assets  : ${stats.resources}
                Duration        : ${"%.2f".format(durationSeconds)} s

                Layout:
                  sources/    - Decompiled Java source files
                  resources/  - Non-class resources from the JAR (assets, mcmod.info, etc.)
                  errors/     - Per-class decompile errors (if any)

                Decompiled with CFR.
                Output bundle licensed under AGPLv3.
            """.trimIndent(),
        )
    }

    private fun deriveZipName(sourceFileName: String): String {
        var base = sourceFileName.substringBeforeLast('.', sourceFileName)
        if (base.isBlank()) base = "mod"
        val sanitized = Regex("[^A-Za-z0-9._-]").replace(base, "_")
        return "$sanitized-sources-${System.currentTimeMillis()}.zip"
    }

    private fun clearDirectory(dir: File) {
        if (!dir.exists()) return
        dir.listFiles()?.forEach { child ->
            if (child.isDirectory) {
                clearDirectory(child)
            }
            child.delete()
        }
    }
}
