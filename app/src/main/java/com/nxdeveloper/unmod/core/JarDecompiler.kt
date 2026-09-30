package com.nxdeveloper.unmod.core

import org.benf.cfr.reader.api.CfrDriver
import org.benf.cfr.reader.api.OutputSinkFactory
import org.benf.cfr.reader.api.SinkReturns
import java.io.File
import java.util.zip.ZipFile

/**
 * Decompiles every `.class` entry in a JAR to Java source using CFR, copying any other
 * (non-class) entries into `resources/` untouched.
 */
class JarDecompiler {

    data class Stats(
        val totalClasses: Int,
        val decompiled: Int,
        val failed: Int,
        val resources: Int,
        val durationMs: Long,
    )

    suspend fun decompile(
        jarFile: File,
        outputDir: File,
        onProgress: (current: Int, total: Int, currentClass: String) -> Unit,
    ): Result<Stats> = kotlinx.coroutines.withContext(kotlinx.coroutines.Dispatchers.IO) {
        runCatching {
            val startedAt = System.currentTimeMillis()
            outputDir.mkdirs()

            val classEntries = ArrayList<String>()
            var resourceCount = 0

            ZipFile(jarFile).use { zip ->
                val entries = zip.entries()
                while (entries.hasMoreElements()) {
                    val entry = entries.nextElement()
                    if (entry.isDirectory) continue
                    if (!entry.name.endsWith(".class")) {
                        val target = File(outputDir, "resources/${entry.name}")
                        target.parentFile?.mkdirs()
                        zip.getInputStream(entry).use { input ->
                            target.outputStream().use { output -> input.copyTo(output) }
                        }
                        resourceCount++
                    } else {
                        classEntries.add(entry.name)
                    }
                }
            }

            val totalClasses = classEntries.size
            val decompiled = intArrayOf(0)
            val failed = intArrayOf(0)
            var lastEmittedClass = ""

            val sinkFactory = object : OutputSinkFactory {
                override fun getSupportedSinks(
                    sinkType: OutputSinkFactory.SinkType,
                    available: Collection<OutputSinkFactory.SinkClass>,
                ): MutableList<OutputSinkFactory.SinkClass> = when (sinkType) {
                    OutputSinkFactory.SinkType.JAVA -> mutableListOf(OutputSinkFactory.SinkClass.DECOMPILED)
                    OutputSinkFactory.SinkType.EXCEPTION -> mutableListOf(OutputSinkFactory.SinkClass.EXCEPTION_MESSAGE)
                    else -> mutableListOf(OutputSinkFactory.SinkClass.STRING)
                }

                override fun <T : Any?> getSink(
                    sinkType: OutputSinkFactory.SinkType,
                    sinkClass: OutputSinkFactory.SinkClass,
                ): OutputSinkFactory.Sink<T> = when (sinkType) {
                    OutputSinkFactory.SinkType.JAVA -> OutputSinkFactory.Sink<T> { result ->
                        val decompiledResult = result as SinkReturns.Decompiled
                        val packageName = decompiledResult.packageName ?: ""
                        val className = decompiledResult.className
                        val java = decompiledResult.java
                        val relativePath = if (packageName.isNotEmpty()) {
                            "${packageName.replace('.', '/')}/$className.java"
                        } else {
                            "$className.java"
                        }
                        val outFile = File(outputDir, "sources/$relativePath")
                        outFile.parentFile?.mkdirs()
                        outFile.writeText(java!!, Charsets.UTF_8)
                        decompiled[0]++
                        lastEmittedClass = if (packageName.isNotEmpty()) "$packageName.$className" else className
                        onProgress(decompiled[0] + failed[0], totalClasses, lastEmittedClass)
                    }
                    OutputSinkFactory.SinkType.EXCEPTION -> OutputSinkFactory.Sink<T> { result ->
                        val exceptionMessage = result as? SinkReturns.ExceptionMessage
                        val path = exceptionMessage?.path ?: "unknown"
                        val message = exceptionMessage?.message ?: "unknown"
                        val errorFile = File(outputDir, "errors/${sanitize(path)}.txt")
                        errorFile.parentFile?.mkdirs()
                        errorFile.writeText("Class: $path\n\nError:\n$message\n", Charsets.UTF_8)
                        failed[0]++
                        onProgress(decompiled[0] + failed[0], totalClasses, "FAILED: $path")
                    }
                    else -> OutputSinkFactory.Sink<T> { }
                } as OutputSinkFactory.Sink<T>
            }

            val options = mapOf(
                "silent" to "true",
                "recover" to "true",
                "lenient" to "true",
                "decodeenumswitch" to "true",
                "sugarenums" to "true",
                "decodestringswitch" to "true",
                "arrayiter" to "true",
                "collectioniter" to "true",
                "innerclasses" to "true",
                "removeboilerplate" to "true",
                "removeinnerclasssynthetics" to "true",
                "hideutf" to "true",
                "hidelongstrings" to "false",
                "removebadgenerics" to "true",
                "sugarasserts" to "true",
                "sugarboxing" to "true",
                "showversion" to "false",
                "decodefinally" to "true",
                "tidymonitors" to "true",
                "dumpclasspath" to "false",
                "comments" to "false",
                "forcetopsort" to "true",
                "forcetopsortaggress" to "true",
                "stringbuffer" to "false",
                "stringbuilder" to "true",
                "j14classobj" to "false",
                "hidebridgemethods" to "true",
                "relinkconststring" to "true",
                "liftconstructorinit" to "true",
                "removedeadmethods" to "false",
                "showinferrable" to "false",
                "forloopaggcapture" to "true",
            )

            val driver = CfrDriver.Builder()
                .withOptions(options)
                .withOutputSink(sinkFactory)
                .build()
            driver.analyse(listOf(jarFile.absolutePath))

            val durationMs = System.currentTimeMillis() - startedAt
            Stats(totalClasses, decompiled[0], failed[0], resourceCount, durationMs)
        }
    }

    private fun sanitize(name: String): String = Regex("[^A-Za-z0-9._-]").replace(name, "_")
}
