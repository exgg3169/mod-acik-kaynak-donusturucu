package com.nxdeveloper.unmod.core

import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import java.io.File
import java.io.FileOutputStream
import java.net.HttpURLConnection
import java.net.URL
import java.util.zip.ZipFile

/** Downloads a mod JAR from a direct URL (Modrinth/CurseForge "download" links) into the cache. */
class JarDownloader {

    suspend fun download(
        url: String,
        outputFile: File,
        onProgress: (downloaded: Long, total: Long) -> Unit,
    ): Result<File> = withContext(Dispatchers.IO) {
        runCatching {
            val connection = URL(url).openConnection() as HttpURLConnection
            connection.connectTimeout = 30_000
            connection.readTimeout = 60_000
            connection.requestMethod = "GET"
            connection.setRequestProperty("User-Agent", "NX-Uninstaller/1.0 (Android; github.com/NX-developer)")
            connection.setRequestProperty("Accept", "*/*")
            connection.instanceFollowRedirects = true
            connection.connect()

            val responseCode = connection.responseCode
            if (responseCode !in 200 until 300) {
                connection.disconnect()
                throw IllegalStateException("HTTP $responseCode while downloading")
            }

            val total = connection.contentLength.toLong()
            outputFile.parentFile?.mkdirs()
            if (outputFile.exists()) outputFile.delete()

            var downloaded = 0L
            var lastEmitted = 0L
            connection.inputStream.use { input ->
                FileOutputStream(outputFile).use { output ->
                    val buffer = ByteArray(65536)
                    while (true) {
                        val read = input.read(buffer)
                        if (read == -1) break
                        output.write(buffer, 0, read)
                        downloaded += read
                        if (downloaded - lastEmitted > 131072 || downloaded == total) {
                            onProgress(downloaded, total)
                            lastEmitted = downloaded
                        }
                    }
                    output.flush()
                }
            }
            connection.disconnect()

            if (!isValidJar(outputFile)) {
                outputFile.delete()
                throw IllegalStateException("Downloaded file is not a valid JAR archive")
            }
            outputFile
        }
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
