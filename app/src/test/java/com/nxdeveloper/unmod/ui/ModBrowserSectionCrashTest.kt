package com.nxdeveloper.unmod.ui

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.ui.Modifier
import androidx.compose.ui.test.junit4.createComposeRule
import com.nxdeveloper.unmod.core.mods.ModHit
import com.nxdeveloper.unmod.core.mods.ModProvider
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith
import org.robolectric.RobolectricTestRunner
import org.robolectric.annotation.Config

/**
 * Regression test for the crash reported when a Modrinth search with an empty query/no filters
 * actually returns results: `ModBrowserSection`'s hits `LazyColumn` lives inside `MainScreen`'s
 * own vertically-scrolling `Column`, and composing a `LazyColumn` with no bounded height inside
 * another scrollable container throws
 * "Vertically scrollable component was measured with an infinity maximum height constraints"
 * as soon as it has at least one item — which is exactly why this only showed up once a search
 * actually returned hits, not on first launch (where the list starts empty).
 */
@RunWith(RobolectricTestRunner::class)
@Config(sdk = [34])
class ModBrowserSectionCrashTest {

    @get:Rule
    val composeRule = createComposeRule()

    @Test
    fun `mod browser section with results does not crash when scrolled inside a Column`() {
        val hits = (1..20).map { i ->
            ModHit(
                provider = ModProvider.MODRINTH,
                id = "mod-$i",
                name = "Mod $i",
                author = "author-$i",
                description = "description $i",
                iconUrl = null,
                downloads = i.toLong(),
            )
        }
        val browserState = MainViewModel.BrowserState(
            hits = hits,
            totalCount = 76541,
            hasNext = true,
        )

        composeRule.setContent {
            Column(modifier = Modifier.fillMaxWidth().verticalScroll(rememberScrollState())) {
                ModBrowserSection(
                    browser = browserState,
                    onQueryChange = {},
                    onSearch = {},
                    onProviderChange = {},
                    onLoaderChange = {},
                    onMcVersionChange = {},
                    onSelectMod = {},
                    onPrevPage = {},
                    onNextPage = {},
                    onFirstPage = {},
                    onLastPage = {},
                )
            }
        }

        composeRule.waitForIdle()
    }
}
