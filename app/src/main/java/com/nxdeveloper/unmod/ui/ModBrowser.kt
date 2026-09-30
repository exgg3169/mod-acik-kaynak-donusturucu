@file:OptIn(androidx.compose.material3.ExperimentalMaterial3Api::class)

package com.nxdeveloper.unmod.ui

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Download
import androidx.compose.material3.Button
import androidx.compose.material3.Card
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.FilterChip
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.ModalBottomSheet
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.SegmentedButton
import androidx.compose.material3.SingleChoiceSegmentedButtonRow
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.nxdeveloper.unmod.core.GameVersions
import com.nxdeveloper.unmod.core.mods.ModFile
import com.nxdeveloper.unmod.core.mods.ModHit
import com.nxdeveloper.unmod.core.mods.ModLoader
import com.nxdeveloper.unmod.core.mods.ModProvider

@Composable
fun ModBrowserSection(
    browser: MainViewModel.BrowserState,
    onQueryChange: (String) -> Unit,
    onSearch: () -> Unit,
    onProviderChange: (ModProvider) -> Unit,
    onLoaderChange: (ModLoader) -> Unit,
    onMcVersionChange: (String) -> Unit,
    onSelectMod: (ModHit) -> Unit,
    onPrevPage: () -> Unit,
    onNextPage: () -> Unit,
    onFirstPage: () -> Unit,
    onLastPage: () -> Unit,
) {
    val isCurseForge = browser.provider == ModProvider.CURSEFORGE
    val strings = LocalStrings.current

    Column(modifier = Modifier.fillMaxWidth(), verticalArrangement = Arrangement.spacedBy(8.dp)) {
        ProviderToggle(browser.provider, onProviderChange)

        if (isCurseForge) {
            Text(
                strings.curseforgeNoSearchNotice,
                style = androidx.compose.material3.MaterialTheme.typography.bodySmall,
            )
        }

        OutlinedTextField(
            value = browser.query,
            onValueChange = onQueryChange,
            modifier = Modifier.fillMaxWidth(),
            label = { Text(if (isCurseForge) strings.curseforgeLinkLabel else strings.searchModsLabel) },
        )

        if (!isCurseForge) {
            LoaderChips(browser.loader, onLoaderChange)

            OutlinedTextField(
                value = browser.mcVersion,
                onValueChange = onMcVersionChange,
                modifier = Modifier.fillMaxWidth(),
                label = { Text(strings.mcVersionOptionalLabel) },
            )
        }

        Button(onClick = onSearch, modifier = Modifier.fillMaxWidth(), enabled = !browser.searching) {
            Text(
                when {
                    browser.searching && isCurseForge -> strings.loading
                    browser.searching -> strings.searching
                    isCurseForge -> strings.load
                    else -> strings.search
                },
            )
        }

        browser.error?.let { Text(it, color = androidx.compose.material3.MaterialTheme.colorScheme.error) }

        if (browser.hits.isNotEmpty()) {
            // Bounded height: this list lives inside MainScreen's own verticalScroll Column,
            // and a LazyColumn measured with an unbounded (infinite) height crashes with
            // "Vertically scrollable component was measured with an infinity maximum height".
            LazyColumn(modifier = Modifier.fillMaxWidth().heightIn(max = 480.dp)) {
                items(browser.hits) { hit ->
                    ModHitRow(hit, onClick = { onSelectMod(hit) })
                }
            }
            if (!isCurseForge) {
                PageControls(browser.page, browser.totalPages, browser.hasPrev, browser.hasNext, onFirstPage, onPrevPage, onNextPage, onLastPage)
            }
        }
    }
}

@Composable
fun ProviderToggle(selected: ModProvider, onChange: (ModProvider) -> Unit) {
    SingleChoiceSegmentedButtonRow(modifier = Modifier.fillMaxWidth()) {
        ModProvider.entries.forEachIndexed { index, provider ->
            SegmentedButton(
                selected = provider == selected,
                onClick = { onChange(provider) },
                shape = androidx.compose.material3.SegmentedButtonDefaults.itemShape(index, ModProvider.entries.size),
            ) {
                Text(provider.label)
            }
        }
    }
}

@Composable
fun LoaderChips(selected: ModLoader, onChange: (ModLoader) -> Unit) {
    Row(horizontalArrangement = Arrangement.spacedBy(6.dp)) {
        ModLoader.entries.forEach { loader ->
            FilterChip(
                selected = loader == selected,
                onClick = { onChange(loader) },
                label = { Text(loader.label) },
            )
        }
    }
}

@Composable
fun GameVersionChips(selected: String, onChange: (String) -> Unit) {
    Row(horizontalArrangement = Arrangement.spacedBy(6.dp)) {
        GameVersions.common.forEach { version ->
            val value = if (version == "Any") "" else version
            FilterChip(
                selected = selected == value,
                onClick = { onChange(value) },
                label = { Text(version) },
            )
        }
    }
}

@Composable
fun ModHitRow(hit: ModHit, onClick: () -> Unit) {
    val strings = LocalStrings.current
    Card(modifier = Modifier.fillMaxWidth().padding(vertical = 4.dp), onClick = onClick) {
        Column(modifier = Modifier.padding(12.dp)) {
            Text(hit.name, style = androidx.compose.material3.MaterialTheme.typography.titleMedium)
            Text("${strings.by} ${hit.author}", style = androidx.compose.material3.MaterialTheme.typography.bodySmall)
            if (hit.description.isNotBlank()) {
                Text(hit.description, style = androidx.compose.material3.MaterialTheme.typography.bodyMedium, maxLines = 2)
            }
            Text("${hit.downloads} ${strings.downloads} · ${hit.provider.label}", style = androidx.compose.material3.MaterialTheme.typography.labelSmall)
        }
    }
}

@Composable
fun ModFileRow(file: ModFile, onDownload: () -> Unit) {
    Card(modifier = Modifier.fillMaxWidth().padding(vertical = 4.dp)) {
        Row(
            modifier = Modifier.fillMaxWidth().padding(12.dp),
            horizontalArrangement = Arrangement.SpaceBetween,
        ) {
            Column {
                Text(file.displayName, style = androidx.compose.material3.MaterialTheme.typography.titleSmall)
                Text(file.fileName, style = androidx.compose.material3.MaterialTheme.typography.bodySmall)
                Text(file.gameVersions.joinToString(", "), style = androidx.compose.material3.MaterialTheme.typography.labelSmall)
            }
            IconButton(onClick = onDownload, enabled = file.downloadUrl != null) {
                Icon(Icons.Filled.Download, contentDescription = "Download")
            }
        }
    }
}

@Composable
fun ModFilesSheet(
    mod: ModHit,
    files: List<ModFile>,
    loading: Boolean,
    onDismiss: () -> Unit,
    onDownload: (ModFile) -> Unit,
) {
    ModalBottomSheet(onDismissRequest = onDismiss) {
        Column(modifier = Modifier.padding(16.dp)) {
            Text(mod.name, style = androidx.compose.material3.MaterialTheme.typography.headlineSmall)
            if (loading) {
                CircularProgressIndicator(modifier = Modifier.padding(16.dp))
            } else if (files.isEmpty()) {
                Text(LocalStrings.current.noFilesForFilters)
            } else {
                LazyColumn {
                    items(files) { file ->
                        ModFileRow(file, onDownload = { onDownload(file) })
                    }
                }
            }
        }
    }
}

@Composable
fun PageControls(
    page: Int,
    totalPages: Int,
    hasPrev: Boolean,
    hasNext: Boolean,
    onFirst: () -> Unit,
    onPrev: () -> Unit,
    onNext: () -> Unit,
    onLast: () -> Unit,
) {
    Row(
        modifier = Modifier.fillMaxWidth().padding(vertical = 4.dp),
        horizontalArrangement = Arrangement.Center,
    ) {
        PageButton("«", enabled = hasPrev, onClick = onFirst)
        PageButton("‹", enabled = hasPrev, onClick = onPrev)
        Text(
            LocalStrings.current.pageOf.format(page + 1, totalPages),
            modifier = Modifier.padding(horizontal = 12.dp),
        )
        PageButton("›", enabled = hasNext, onClick = onNext)
        PageButton("»", enabled = hasNext, onClick = onLast)
    }
}

@Composable
fun PageButton(label: String, enabled: Boolean, onClick: () -> Unit) {
    IconButton(onClick = onClick, enabled = enabled) {
        Text(label)
    }
}
