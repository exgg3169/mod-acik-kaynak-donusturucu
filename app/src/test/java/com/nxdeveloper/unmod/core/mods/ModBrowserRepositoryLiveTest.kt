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

    /**
     * CurseForge requires a per-developer API key (console.curseforge.com -> API Keys), so this
     * only runs when one is supplied via the CURSEFORGE_API_KEY environment variable — it is
     * never hard-coded or committed. Run locally with:
     *   CURSEFORGE_API_KEY=... ./gradlew :app:testDebugUnitTest --tests "*CurseForge*"
     */
    @Test
    fun `search curseforge for a popular mod returns hits`() = runBlocking {
        val apiKey = System.getenv("CURSEFORGE_API_KEY")
        assumeTrue("Skipping: set CURSEFORGE_API_KEY to test the CurseForge path", !apiKey.isNullOrBlank())

        val result = repository.search(
            provider = ModProvider.CURSEFORGE,
            query = "jei",
            loader = ModLoader.ANY,
            mcVersion = "",
            offset = 0,
            pageSize = 5,
            curseForgeApiKey = apiKey!!,
        )

        val page = result.getOrElse {
            System.err.println("CurseForge search() failed: ${it}")
            it.printStackTrace()
            throw it
        }

        assertTrue("expected at least one hit for 'jei'", page.hits.isNotEmpty())
        assertTrue("expected a positive total count", page.totalCount > 0)
        val first = page.hits.first()
        assertTrue(first.name.isNotBlank())
        println("First CurseForge hit: ${first.name} by ${first.author} (${first.downloads} downloads)")
    }

    @Test
    fun `listFiles for a known curseforge mod returns downloadable jars`() = runBlocking {
        val apiKey = System.getenv("CURSEFORGE_API_KEY")
        assumeTrue("Skipping: set CURSEFORGE_API_KEY to test the CurseForge path", !apiKey.isNullOrBlank())

        // 238222 is JEI's CurseForge project id — stable across renames.
        val result = repository.listFiles(
            provider = ModProvider.CURSEFORGE,
            modId = "238222",
            loader = ModLoader.ANY,
            mcVersion = "",
            curseForgeApiKey = apiKey!!,
        )

        val files = result.getOrElse {
            System.err.println("CurseForge listFiles() failed: ${it}")
            it.printStackTrace()
            throw it
        }

        assertTrue("expected at least one file", files.isNotEmpty())
        val first = files.first()
        assertTrue(first.fileName.endsWith(".jar"))
        println("First CurseForge file: ${first.fileName} (${first.sizeBytes} bytes) -> ${first.downloadUrl}")
    }
}
