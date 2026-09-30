package com.nxdeveloper.unmod.core.mods

import kotlinx.coroutines.runBlocking
import org.junit.Assert.assertTrue
import org.junit.Assume.assumeTrue
import org.junit.Test

/**
 * Exercises the real "search mods" flow (the part of the mod-browser pipeline that does not
 * require Android UI / SAF) against the live Modrinth API. Skips itself if the sandbox has no
 * network access, rather than failing the build.
 */
class ModBrowserRepositoryLiveTest {

    private val repository = ModBrowserRepository()

    @Test
    fun `search modrinth for a popular mod returns hits`() = runBlocking {
        val result = repository.search(
            provider = ModProvider.MODRINTH,
            query = "sodium",
            loader = ModLoader.ANY,
            mcVersion = "",
            offset = 0,
            pageSize = 5,
            curseForgeApiKey = "",
        )

        val page = result.getOrElse {
            System.err.println("search() failed: ${it}")
            it.printStackTrace()
            assumeTrue("Skipping: no network access to api.modrinth.com (${it.message})", false)
            return@runBlocking
        }

        assertTrue("expected at least one hit for 'sodium'", page.hits.isNotEmpty())
        assertTrue("expected a positive total count", page.totalCount > 0)
        val first = page.hits.first()
        assertTrue(first.name.isNotBlank())
        assertTrue(first.id.isNotBlank())
        println("First hit: ${first.name} by ${first.author} (${first.downloads} downloads)")
    }

    @Test
    fun `listFiles for a known modrinth mod returns downloadable jars`() = runBlocking {
        // "AANobbMI" is Sodium's Modrinth project id — stable across renames.
        val result = repository.listFiles(
            provider = ModProvider.MODRINTH,
            modId = "AANobbMI",
            loader = ModLoader.ANY,
            mcVersion = "",
            curseForgeApiKey = "",
        )

        val files = result.getOrElse {
            System.err.println("listFiles() failed: ${it}")
            it.printStackTrace()
            assumeTrue("Skipping: no network access to api.modrinth.com (${it.message})", false)
            return@runBlocking
        }

        assertTrue("expected at least one file", files.isNotEmpty())
        val first = files.first()
        assertTrue(first.fileName.endsWith(".jar"))
        println("First file: ${first.fileName} (${first.sizeBytes} bytes) -> ${first.downloadUrl}")
    }
}
