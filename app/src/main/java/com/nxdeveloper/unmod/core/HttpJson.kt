package com.nxdeveloper.unmod.core

import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import java.net.HttpURLConnection
import java.net.URL

/** Minimal blocking HTTP GET helper used by the settings/mod-browser plumbing. */
object HttpJson {

    private const val USER_AGENT = "NX-developer/NX-Un-Minecraft-Java-mod (Android NX Uninstaller)"

    class HttpException(val code: Int, val body: String) : Exception("HTTP $code: ${body.take(200)}")

    suspend fun get(url: String, headers: Map<String, String> = emptyMap()): Result<String> =
        withContext(Dispatchers.IO) {
            runCatching {
                val connection = URL(url).openConnection() as HttpURLConnection
                connection.connectTimeout = 20_000
                connection.readTimeout = 30_000
                connection.requestMethod = "GET"
                connection.setRequestProperty("User-Agent", USER_AGENT)
                connection.setRequestProperty("Accept", "application/json")
                headers.forEach { (key, value) -> connection.setRequestProperty(key, value) }
                connection.instanceFollowRedirects = true
                connection.connect()

                val responseCode = connection.responseCode
                val ok = responseCode in 200 until 300
                val stream = if (ok) connection.inputStream else connection.errorStream
                val body = stream?.bufferedReader(Charsets.UTF_8)?.use { it.readText() } ?: ""
                connection.disconnect()

                if (!ok) throw HttpException(responseCode, body)
                body
            }
        }
}
