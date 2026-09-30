package com.nxdeveloper.unmod.core.mods

import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import org.json.JSONArray
import org.json.JSONObject
import java.net.HttpURLConnection
import java.net.URL
import java.net.URLEncoder

/** Talks to the Modrinth and CurseForge public APIs to search mods and list their files. */
class ModBrowserRepository {

    suspend fun search(
        provider: ModProvider,
        query: String,
        loader: ModLoader,
        mcVersion: String,
        offset: Int,
        pageSize: Int,
        curseForgeApiKey: String,
    ): Result<ModSearchPage> = withContext(Dispatchers.IO) {
        runCatching {
            when (provider) {
                ModProvider.MODRINTH -> searchModrinth(query, loader, mcVersion, offset, pageSize)
                ModProvider.CURSEFORGE -> searchCurseForge(query, loader, mcVersion, curseForgeApiKey, offset, pageSize)
            }
        }
    }

    suspend fun listFiles(
        provider: ModProvider,
        modId: String,
        loader: ModLoader,
        mcVersion: String,
        curseForgeApiKey: String,
    ): Result<List<ModFile>> = withContext(Dispatchers.IO) {
        runCatching {
            when (provider) {
                ModProvider.MODRINTH -> listModrinthFiles(modId, loader, mcVersion)
                ModProvider.CURSEFORGE -> listCurseForgeFiles(modId, loader, mcVersion, curseForgeApiKey)
            }
        }
    }

    private fun searchModrinth(query: String, loader: ModLoader, mcVersion: String, offset: Int, pageSize: Int): ModSearchPage {
        val facetGroups = buildList {
            add(listOf("project_type:mod"))
            loader.modrinth?.let { add(listOf("categories:$it")) }
            if (mcVersion.isNotBlank()) add(listOf("versions:${mcVersion.trim()}"))
        }
        val facets = JSONArray(facetGroups.map { JSONArray(it) }).toString()
        val url = "https://api.modrinth.com/v2/search?query=${enc(query)}&limit=$pageSize&offset=$offset&index=relevance&facets=${enc(facets)}"
        val json = JSONObject(httpGet(url, emptyMap()))
        val hits = json.optJSONArray("hits") ?: JSONArray()
        val total = json.optInt("total_hits", hits.length())

        val results = ArrayList<ModHit>(hits.length())
        for (i in 0 until hits.length()) {
            val hit = hits.getJSONObject(i)
            val icon = hit.optString("icon_url", "").ifBlank { null }
            results.add(
                ModHit(
                    provider = ModProvider.MODRINTH,
                    id = hit.optString("project_id", hit.optString("slug")),
                    name = hit.optString("title", "Unknown"),
                    author = hit.optString("author", ""),
                    description = hit.optString("description", ""),
                    iconUrl = icon,
                    downloads = hit.optLong("downloads", 0),
                ),
            )
        }
        return ModSearchPage(results, total)
    }

    private fun searchCurseForge(query: String, loader: ModLoader, mcVersion: String, apiKey: String, offset: Int, pageSize: Int): ModSearchPage {
        require(apiKey.isNotBlank()) { "CurseForge API key is required. Add it in Settings." }
        val index = offset.coerceIn(0, 10000 - pageSize).coerceAtLeast(0)
        val url = buildString {
            append("https://api.curseforge.com/v1/mods/search")
            append("?gameId=432")
            append("&classId=6")
            append("&searchFilter=").append(enc(query))
            append("&sortField=2")
            append("&sortOrder=desc")
            append("&pageSize=").append(pageSize)
            append("&index=").append(index)
            if (loader != ModLoader.ANY) append("&modLoaderType=").append(loader.curseforge)
            if (mcVersion.isNotBlank()) append("&gameVersion=").append(enc(mcVersion.trim()))
        }
        val json = JSONObject(httpGet(url, mapOf("x-api-key" to apiKey, "Accept" to "application/json")))
        val data = json.optJSONArray("data") ?: JSONArray()
        val totalCount = (json.optJSONObject("pagination")?.optInt("totalCount", data.length()) ?: data.length())
            .coerceAtMost(10000)

        val results = ArrayList<ModHit>(data.length())
        for (i in 0 until data.length()) {
            val mod = data.getJSONObject(i)
            val author = mod.optJSONArray("authors")?.takeIf { it.length() > 0 }?.getJSONObject(0)?.optString("name", "") ?: ""
            val icon = mod.optJSONObject("logo")?.optString("thumbnailUrl", "")?.ifBlank { null }
            results.add(
                ModHit(
                    provider = ModProvider.CURSEFORGE,
                    id = mod.optLong("id").toString(),
                    name = mod.optString("name", "Unknown"),
                    author = author,
                    description = mod.optString("summary", ""),
                    iconUrl = icon,
                    downloads = mod.optLong("downloadCount", 0),
                ),
            )
        }
        return ModSearchPage(results, totalCount)
    }

    private fun listModrinthFiles(modId: String, loader: ModLoader, mcVersion: String): List<ModFile> {
        val extra = buildString {
            loader.modrinth?.let { append("&loaders=").append(enc(JSONArray(listOf(it)).toString())) }
            if (mcVersion.isNotBlank()) append("&game_versions=").append(enc(JSONArray(listOf(mcVersion.trim())).toString()))
        }
        val versions = JSONArray(httpGet("https://api.modrinth.com/v2/project/${enc(modId)}/version?dummy=1$extra", emptyMap()))
        val results = ArrayList<ModFile>(versions.length())
        for (i in 0 until versions.length()) {
            val version = versions.getJSONObject(i)
            val files = version.optJSONArray("files") ?: continue
            var primary: JSONObject? = null
            for (f in 0 until files.length()) {
                val file = files.getJSONObject(f)
                if (file.optBoolean("primary", false)) {
                    primary = file
                    break
                }
                if (primary == null) primary = file
            }
            val file = primary ?: continue
            val fileName = file.optString("filename", "")
            if (!fileName.endsWith(".jar")) continue
            val downloadUrl = file.optString("url", "").ifBlank { null }
            results.add(
                ModFile(
                    id = version.optString("id"),
                    displayName = version.optString("name", version.optString("version_number", fileName)),
                    fileName = fileName,
                    downloadUrl = downloadUrl,
                    sizeBytes = file.optLong("size", 0),
                    gameVersions = toStringList(version.optJSONArray("game_versions")),
                    loaders = toStringList(version.optJSONArray("loaders")),
                ),
            )
        }
        return results
    }

    private fun listCurseForgeFiles(modId: String, loader: ModLoader, mcVersion: String, apiKey: String): List<ModFile> {
        require(apiKey.isNotBlank()) { "CurseForge API key is required. Add it in Settings." }
        val url = buildString {
            append("https://api.curseforge.com/v1/mods/").append(enc(modId)).append("/files")
            append("?pageSize=40")
            if (loader != ModLoader.ANY) append("&modLoaderType=").append(loader.curseforge)
            if (mcVersion.isNotBlank()) append("&gameVersion=").append(enc(mcVersion.trim()))
        }
        val data = JSONObject(httpGet(url, mapOf("x-api-key" to apiKey, "Accept" to "application/json"))).optJSONArray("data") ?: JSONArray()
        val results = ArrayList<ModFile>(data.length())
        for (i in 0 until data.length()) {
            val file = data.getJSONObject(i)
            val fileName = file.optString("fileName", "")
            if (!fileName.endsWith(".jar")) continue
            val downloadUrl = file.optString("downloadUrl", "").ifBlank { null }
            results.add(
                ModFile(
                    id = file.optLong("id").toString(),
                    displayName = file.optString("displayName", fileName),
                    fileName = fileName,
                    downloadUrl = downloadUrl,
                    sizeBytes = file.optLong("fileLength", 0),
                    gameVersions = toStringList(file.optJSONArray("gameVersions")),
                    loaders = emptyList(),
                ),
            )
        }
        return results
    }

    private fun toStringList(array: JSONArray?): List<String> {
        if (array == null) return emptyList()
        return (0 until array.length()).map { array.optString(it) }
    }

    private fun enc(value: String): String = URLEncoder.encode(value, "UTF-8")

    private fun httpGet(url: String, headers: Map<String, String>): String {
        val connection = URL(url).openConnection() as HttpURLConnection
        connection.connectTimeout = 20_000
        connection.readTimeout = 30_000
        connection.requestMethod = "GET"
        connection.setRequestProperty("User-Agent", "NX-Uninstaller/1.0 (Android; github.com/NX-developer)")
        headers.forEach { (key, value) -> connection.setRequestProperty(key, value) }
        connection.instanceFollowRedirects = true
        connection.connect()

        val responseCode = connection.responseCode
        val ok = responseCode in 200 until 300
        val stream = if (ok) connection.inputStream else connection.errorStream
        val body = stream?.bufferedReader(Charsets.UTF_8)?.use { it.readText() } ?: ""
        connection.disconnect()

        if (!ok) throw IllegalStateException("HTTP $responseCode: ${body.take(200)}")
        return body
    }
}
