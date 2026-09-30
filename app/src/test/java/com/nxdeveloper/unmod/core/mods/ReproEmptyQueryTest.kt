package com.nxdeveloper.unmod.core.mods

import kotlinx.coroutines.runBlocking
import org.junit.Test

class ReproEmptyQueryTest {
    @Test
    fun `reproduce empty query any loader no version`() = runBlocking {
        val repo = ModBrowserRepository()
        val result = repo.search(
            provider = ModProvider.MODRINTH,
            query = "",
            loader = ModLoader.ANY,
            mcVersion = "",
            offset = 0,
            pageSize = 20,
        )
        result.onSuccess { println("OK hits=${it.hits.size} total=${it.totalCount}") }
        result.onFailure { it.printStackTrace(); throw it }
        Unit
    }
}
