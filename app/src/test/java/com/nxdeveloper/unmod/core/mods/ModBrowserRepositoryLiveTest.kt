package com.nxdeveloper.unmod.core.mods

import kotlinx.coroutines.runBlocking
import org.junit.Assert.assertTrue
import org.junit.Assume.assumeTrue
import org.junit.Test

/**
 * Exercises the real mod-search/browse flow (the part of the mod-browser pipeline that does not
 * require Android UI / SAF) against live services. Skips itself if the sandbox has no network
 * access, rather than failing the build.
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
        )

        val page = result.getOrElse {
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
        )

        val files = result.getOrElse {
            assumeTrue("Skipping: no network access to api.modrinth.com (${it.message})", false)
            return@runBlocking
        }

        assertTrue("expected at least one file", files.isNotEmpty())
        val first = files.first()
        assertTrue(first.fileName.endsWith(".jar"))
        println("First file: ${first.fileName} (${first.sizeBytes} bytes) -> ${first.downloadUrl}")
    }

    /**
     * CurseForge search is done via a pasted mod page link resolved through CFWidget
     * (api.cfwidget.com) — a free, keyless community proxy — instead of CurseForge's own
     * key-gated Core API. No secret needed to run this.
     */
    @Test
    fun `resolving a pasted curseforge link returns the mod as a single hit`() = runBlocking {
        val result = repository.search(
            provider = ModProvider.CURSEFORGE,
            query = "https://www.curseforge.com/minecraft/mc-mods/jei",
            loader = ModLoader.ANY,
            mcVersion = "",
            offset = 0,
            pageSize = 5,
        )

        val page = result.getOrElse {
            assumeTrue("Skipping: no network access to api.cfwidget.com (${it.message})", false)
            return@runBlocking
        }

        assertTrue("expected exactly one resolved hit", page.hits.size == 1)
        val hit = page.hits.first()
        assertTrue(hit.provider == ModProvider.CURSEFORGE)
        assertTrue(hit.name.isNotBlank())
        println("Resolved CurseForge mod: ${hit.name} by ${hit.author} (${hit.downloads} downloads)")
    }

    @Test
    fun `listFiles for a resolved curseforge mod returns downloadable jars with direct urls`() = runBlocking {
        val result = repository.listFiles(
            provider = ModProvider.CURSEFORGE,
            modId = "minecraft/mc-mods/jei",
            loader = ModLoader.ANY,
            mcVersion = "",
        )

        val files = result.getOrElse {
            assumeTrue("Skipping: no network access to api.cfwidget.com (${it.message})", false)
            return@runBlocking
        }

        assertTrue("expected at least one file", files.isNotEmpty())
        val first = files.first()
        assertTrue(first.fileName.endsWith(".jar"))
        assertTrue("expected a direct download URL", first.downloadUrl?.contains("/download/") == true)
        println("First CurseForge file: ${first.fileName} (${first.sizeBytes} bytes) -> ${first.downloadUrl}")
    }
}
