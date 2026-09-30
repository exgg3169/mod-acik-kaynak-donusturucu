package com.nxdeveloper.unmod.core.mods

import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import org.json.JSONArray
import org.json.JSONObject
import java.net.HttpURLConnection
import java.net.URL
import java.net.URLEncoder

/**
 * Searches mods and lists their downloadable files.
 *
 * Modrinth's public API is used directly (no key needed). CurseForge's own search/files API
 * requires a key that Overwolf must manually approve per developer, so instead of that we
 * resolve a CurseForge mod *page link the user pastes* through CFWidget (api.cfwidget.com), a
 * free, keyless community proxy that's been used by Minecraft launchers for years. That only
 * supports looking up a mod that's already known (by its page URL or numeric id), not full-text
 * search — that limitation is inherent to going keyless, not something this app can work around.
 */
class ModBrowserRepository {

    suspend fun search(
        provider: ModProvider,
        query: String,
        loader: ModLoader,
        mcVersion: String,
        offset: Int,
        pageSize: Int,
    ): Result<ModSearchPage> = withContext(Dispatchers.IO) {
        runCatching {
            when (provider) {
                ModProvider.MODRINTH -> searchModrinth(query, loader, mcVersion, offset, pageSize)
                ModProvider.CURSEFORGE -> resolveCurseForgePage(query)
            }
        }
    }

    suspend fun listFiles(
        provider: ModProvider,
        modId: String,
        loader: ModLoader,
        mcVersion: String,
    ): Result<List<ModFile>> = withContext(Dispatchers.IO) {
        runCatching {
            when (provider) {
                ModProvider.MODRINTH -> listModrinthFiles(modId, loader, mcVersion)
                ModProvider.CURSEFORGE -> listCurseForgeFilesViaWidget(modId)
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

    /**
     * Resolves a pasted CurseForge mod page link (or bare "game/type/slug" path, or numeric
     * project id) via CFWidget, returning it as a single-hit "search page" so the rest of the
     * mod-browser flow (select -> list files -> download) doesn't need a separate code path.
     */
    private fun resolveCurseForgePage(pastedUrlOrPath: String): ModSearchPage {
        val path = extractCurseForgePath(pastedUrlOrPath)
        require(path.isNotBlank()) { "Paste a CurseForge mod page link, e.g. curseforge.com/minecraft/mc-mods/jei" }
        val json = JSONObject(httpGet("https://api.cfwidget.com/$path", emptyMap()))
        return ModSearchPage(listOf(cfWidgetToHit(json, path)), 1)
    }

    private fun listCurseForgeFilesViaWidget(path: String): List<ModFile> {
        val json = JSONObject(httpGet("https://api.cfwidget.com/$path", emptyMap()))
        val filesArray = json.optJSONArray("files") ?: JSONArray()
        val results = ArrayList<ModFile>(filesArray.length())
        for (i in 0 until filesArray.length()) {
            val file = filesArray.getJSONObject(i)
            val fileName = file.optString("name", "")
            if (!fileName.endsWith(".jar")) continue
            val fileId = file.optLong("id")
            results.add(
                ModFile(
                    id = fileId.toString(),
                    displayName = file.optString("display", fileName),
                    fileName = fileName,
                    downloadUrl = curseForgeDirectDownloadUrl(file.optString("url", ""), fileId),
                    sizeBytes = file.optLong("filesize", 0),
                    gameVersions = toStringList(file.optJSONArray("versions")),
                    loaders = emptyList(),
                ),
            )
        }
        // CFWidget returns a mod's entire upload history (can be thousands for old mods);
        // newest first, capped so the file-picker sheet stays usable.
        return results.sortedByDescending { it.id.toLongOrNull() ?: 0L }.take(60)
    }

    private fun cfWidgetToHit(json: JSONObject, path: String): ModHit {
        val members = json.optJSONArray("members")
        val author = if (members != null && members.length() > 0) members.getJSONObject(0).optString("username", "") else ""
        val downloads = json.optJSONObject("downloads")?.optLong("total", 0) ?: 0L
        return ModHit(
            provider = ModProvider.CURSEFORGE,
            id = path,
            name = json.optString("title", "Unknown"),
            author = author,
            description = json.optString("summary", ""),
            iconUrl = json.optString("thumbnail", "").ifBlank { null },
            downloads = downloads,
        )
    }

    /** Accepts a full curseforge.com URL, a bare "game/type/slug" path, or a numeric project id. */
    private fun extractCurseForgePath(input: String): String {
        val trimmed = input.trim()
        if (trimmed.toLongOrNull() != null) return trimmed
        val withoutHost = trimmed.substringAfter("curseforge.com/", trimmed)
        val segments = withoutHost.trim('/').split('/').filter { it.isNotBlank() }
        return segments.take(3).joinToString("/")
    }

    /**
     * CFWidget's file entries link to the file's *details* page (".../files/{id}"), which shows
     * an ad interstitial before downloading. Swapping to ".../download/{id}/file" is the same
     * redirect-straight-to-the-CDN link CurseForge's own "Download" button uses.
     */
    private fun curseForgeDirectDownloadUrl(detailsUrl: String, fileId: Long): String? {
        if (detailsUrl.isBlank() || fileId <= 0) return null
        val downloadPage = detailsUrl.replace("/files/$fileId", "/download/$fileId")
        if (downloadPage == detailsUrl) return null
        return "$downloadPage/file"
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
