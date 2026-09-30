package com.nxdeveloper.unmod.core

import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import java.io.BufferedOutputStream
import java.io.File
import java.io.FileOutputStream
import java.util.zip.ZipEntry
import java.util.zip.ZipOutputStream

/** Zips a decompiled-sources directory into a single, deflate-max archive. */
class SourceZipper {

    suspend fun zipDirectory(
        sourceDir: File,
        outputZip: File,
        onProgress: (current: Int, total: Int) -> Unit,
    ): Result<File> = withContext(Dispatchers.IO) {
        runCatching {
            outputZip.parentFile?.mkdirs()
            if (outputZip.exists()) outputZip.delete()

            val files = ArrayList<File>()
            collectFiles(sourceDir, files)
            val total = files.size

            ZipOutputStream(BufferedOutputStream(FileOutputStream(outputZip))).use { zip ->
                zip.setLevel(9)
                var done = 0
                for (file in files) {
                    val relativePath = file.relativeTo(sourceDir).path.replace('\\', '/')
                    val entry = ZipEntry(relativePath)
                    entry.time = file.lastModified()
                    zip.putNextEntry(entry)
                    file.inputStream().use { input -> input.copyTo(zip) }
                    zip.closeEntry()
                    done++
                    if (done % 25 == 0 || done == total) onProgress(done, total)
                }
                zip.finish()
            }
            outputZip
        }
    }

    private fun collectFiles(dir: File, out: MutableList<File>) {
        dir.listFiles()?.forEach { child ->
            if (child.isDirectory) {
                collectFiles(child, out)
            } else if (child.isFile) {
                out.add(child)
            }
        }
    }
}
