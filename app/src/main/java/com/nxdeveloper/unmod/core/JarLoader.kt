package com.nxdeveloper.unmod.core

import android.content.Context
import android.net.Uri
import android.provider.OpenableColumns
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import java.io.File
import java.io.FileOutputStream
import java.util.zip.ZipFile

/** Copies a user-picked `content://` JAR/ZIP Uri into the app cache. */
class JarLoader(private val context: Context) {

    data class PickedFile(val displayName: String, val sizeBytes: Long, val cachedFile: File)

    suspend fun copyToCache(
        sourceUri: Uri,
        targetFile: File,
        onProgress: (copied: Long, total: Long) -> Unit,
    ): Result<PickedFile> = withContext(Dispatchers.IO) {
        runCatching {
            val (queriedName, queriedSize) = queryMetadata(sourceUri)
            val displayName = queriedName ?: "input.jar"
            var total = queriedSize

            targetFile.parentFile?.mkdirs()
            if (targetFile.exists()) targetFile.delete()

            var copied = 0L
            var lastEmitted = 0L
            val input = context.contentResolver.openInputStream(sourceUri)
                ?: throw IllegalStateException("Cannot open input stream for $sourceUri")
            input.use { source ->
                FileOutputStream(targetFile).use { output ->
                    val buffer = ByteArray(65536)
                    while (true) {
                        val read = source.read(buffer)
                        if (read == -1) break
                        output.write(buffer, 0, read)
                        copied += read
                        if (copied - lastEmitted > 262144 || copied == total) {
                            onProgress(copied, total)
                            lastEmitted = copied
                        }
                    }
                    output.flush()
                }
            }

            if (!isValidJar(targetFile)) {
                targetFile.delete()
                throw IllegalStateException("Selected file is not a valid JAR/ZIP archive")
            }
            if (total <= 0) total = targetFile.length()
            PickedFile(displayName, total, targetFile)
        }
    }

    private fun queryMetadata(uri: Uri): Pair<String?, Long> {
        var name: String? = null
        var size = -1L
        context.contentResolver.query(uri, null, null, null, null)?.use { cursor ->
            if (cursor.moveToFirst()) {
                val nameIndex = cursor.getColumnIndex(OpenableColumns.DISPLAY_NAME)
                val sizeIndex = cursor.getColumnIndex(OpenableColumns.SIZE)
                if (nameIndex >= 0 && !cursor.isNull(nameIndex)) name = cursor.getString(nameIndex)
                if (sizeIndex >= 0 && !cursor.isNull(sizeIndex)) size = cursor.getLong(sizeIndex)
            }
        }
        if (name == null) {
            name = uri.lastPathSegment?.substringAfterLast('/')
        }
        return name to size
    }

    private fun isValidJar(file: File): Boolean {
        if (!file.exists() || file.length() < 16) return false
        return runCatching {
            ZipFile(file).use { zip ->
                val entries = zip.entries()
                var hasClass = false
                while (entries.hasMoreElements()) {
                    if (entries.nextElement().name.endsWith(".class")) {
                        hasClass = true
                        break
                    }
                }
                hasClass
            }
        }.getOrDefault(false)
    }
}
