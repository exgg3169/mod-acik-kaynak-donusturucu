package com.nxdeveloper.unmod.ui

import android.Manifest
import android.net.Uri
import android.os.Build
import android.provider.OpenableColumns
import androidx.activity.compose.rememberLauncherForActivityResult
import androidx.activity.result.contract.ActivityResultContracts
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Settings
import androidx.compose.material3.Button
import androidx.compose.material3.Card
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.LinearProgressIndicator
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedButton
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Switch
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.unit.dp
import com.nxdeveloper.unmod.ui.MainViewModel.UiState

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun MainScreen(viewModel: MainViewModel) {
    val state by viewModel.state.collectAsState()
    val browser by viewModel.browser.collectAsState()
    val context = LocalContext.current

    val notificationPermissionLauncher = rememberLauncherForActivityResult(ActivityResultContracts.RequestPermission()) { }

    val picker = rememberLauncherForActivityResult(ActivityResultContracts.OpenDocument()) { uri: Uri? ->
        if (uri != null) {
            var name = uri.lastPathSegment ?: uri.toString()
            var size = 0L
            context.contentResolver.query(uri, null, null, null, null)?.use { cursor ->
                val nameIdx = cursor.getColumnIndex(OpenableColumns.DISPLAY_NAME)
                val sizeIdx = cursor.getColumnIndex(OpenableColumns.SIZE)
                if (cursor.moveToFirst()) {
                    if (nameIdx >= 0) name = cursor.getString(nameIdx) ?: name
                    if (sizeIdx >= 0) size = cursor.getLong(sizeIdx)
                }
            }
            viewModel.onFilePicked(uri, name, size)
        }
    }

    val onToggleBackground: (Boolean) -> Unit = { enabled ->
        if (enabled && Build.VERSION.SDK_INT >= 33) {
            notificationPermissionLauncher.launch(Manifest.permission.POST_NOTIFICATIONS)
        }
        viewModel.setRunInBackground(enabled)
    }

    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("NX Uninstaller") },
                actions = {
                    IconButton(onClick = { viewModel.openSettings() }) {
                        Icon(Icons.Filled.Settings, contentDescription = "Settings")
                    }
                },
            )
        },
    ) { padding ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(padding)
                .verticalScroll(rememberScrollState())
                .padding(16.dp),
            verticalArrangement = Arrangement.spacedBy(12.dp),
        ) {
            LogoBanner()

            if (state.showSettings) {
                SettingsContent(
                    state = state,
                    onToggleBackground = onToggleBackground,
                    onCurseForgeApiKey = viewModel::setCurseForgeApiKey,
                    onClose = viewModel::closeSettings,
                )
            } else {
                FilePickerCard(
                    state = state,
                    onPick = { picker.launch(arrayOf("application/java-archive", "application/zip", "application/octet-stream", "*/*")) },
                    onClear = viewModel::clearPick,
                    onStart = viewModel::startDecompile,
                )

                if (state.isRunning) {
                    ProgressCard(state, onCancel = viewModel::cancel)
                } else if (state.stage == "Done") {
                    ResultCard(state, onReset = viewModel::reset)
                } else if (state.stage == "Failed") {
                    ErrorCard(state, onDismiss = viewModel::reset)
                }

                Text("Or browse mods online", style = MaterialTheme.typography.titleMedium)
                ModBrowserSection(
                    browser = browser,
                    onQueryChange = viewModel::setQuery,
                    onSearch = viewModel::search,
                    onProviderChange = viewModel::setProvider,
                    onLoaderChange = viewModel::setLoader,
                    onMcVersionChange = viewModel::setMcVersion,
                    onSelectMod = viewModel::selectMod,
                    onPrevPage = viewModel::prevPage,
                    onNextPage = viewModel::nextPage,
                    onFirstPage = viewModel::firstPage,
                    onLastPage = viewModel::lastPage,
                )

                browser.selectedMod?.let { mod ->
                    ModFilesSheet(
                        mod = mod,
                        files = browser.files,
                        loading = browser.loadingFiles,
                        onDismiss = viewModel::closeModFiles,
                        onDownload = viewModel::downloadAndDecompile,
                    )
                }
            }

            FooterText()
        }
    }
}

@Composable
fun LogoBanner() {
    Text(
        "NX Uninstaller",
        style = MaterialTheme.typography.headlineMedium,
        modifier = Modifier.padding(vertical = 8.dp),
    )
}

@Composable
fun FilePickerCard(state: UiState, onPick: () -> Unit, onClear: () -> Unit, onStart: () -> Unit) {
    Card(modifier = Modifier.fillMaxWidth()) {
        Column(modifier = Modifier.padding(16.dp), verticalArrangement = Arrangement.spacedBy(8.dp)) {
            Text("Pick a mod JAR", style = MaterialTheme.typography.titleMedium)
            Text(
                if (state.pickedDisplayName.isNotBlank()) state.pickedDisplayName else "No file selected",
                style = MaterialTheme.typography.bodyMedium,
            )
            Row(horizontalArrangement = Arrangement.spacedBy(8.dp)) {
                Button(onClick = onPick, enabled = !state.isRunning) { Text("Choose file") }
                OutlinedButton(onClick = onClear, enabled = !state.isRunning && state.pickedUri != null) { Text("Clear") }
            }
            Button(
                onClick = onStart,
                enabled = !state.isRunning && state.pickedUri != null,
                modifier = Modifier.fillMaxWidth(),
            ) {
                Text("Decompile")
            }
        }
    }
}

@Composable
fun ProgressCard(state: UiState, onCancel: () -> Unit) {
    Card(modifier = Modifier.fillMaxWidth()) {
        Column(modifier = Modifier.padding(16.dp), verticalArrangement = Arrangement.spacedBy(8.dp)) {
            Text(state.stage, style = MaterialTheme.typography.titleMedium)
            LinearProgressIndicator(progress = { state.progress }, modifier = Modifier.fillMaxWidth())
            Text(state.detail, style = MaterialTheme.typography.bodySmall)
            OutlinedButton(onClick = onCancel) { Text("Cancel") }
        }
    }
}

@Composable
fun ResultCard(state: UiState, onReset: () -> Unit) {
    val stats = state.stats
    Card(modifier = Modifier.fillMaxWidth()) {
        Column(modifier = Modifier.padding(16.dp), verticalArrangement = Arrangement.spacedBy(4.dp)) {
            Text("Done", style = MaterialTheme.typography.titleMedium)
            Text(state.detail, style = MaterialTheme.typography.bodyMedium)
            if (stats != null) {
                StatRow("Total classes", stats.totalClasses.toString())
                StatRow("Decompiled", stats.decompiled.toString())
                StatRow("Failed", stats.failed.toString())
                StatRow("Resources", stats.resources.toString())
            }
            Button(onClick = onReset, modifier = Modifier.fillMaxWidth()) { Text("Decompile another") }
        }
    }
}

@Composable
fun ErrorCard(state: UiState, onDismiss: () -> Unit) {
    Card(modifier = Modifier.fillMaxWidth()) {
        Column(modifier = Modifier.padding(16.dp), verticalArrangement = Arrangement.spacedBy(8.dp)) {
            Text("Failed", style = MaterialTheme.typography.titleMedium, color = MaterialTheme.colorScheme.error)
            Text(state.detail, style = MaterialTheme.typography.bodyMedium)
            state.errorMessage?.let { Text(it, style = MaterialTheme.typography.bodySmall) }
            Button(onClick = onDismiss) { Text("Dismiss") }
        }
    }
}

@Composable
fun StatRow(label: String, value: String) {
    Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween) {
        Text(label, style = MaterialTheme.typography.bodySmall)
        Text(value, style = MaterialTheme.typography.bodySmall)
    }
}

@Composable
fun SettingsContent(
    state: UiState,
    onToggleBackground: (Boolean) -> Unit,
    onCurseForgeApiKey: (String) -> Unit,
    onClose: () -> Unit,
) {
    Card(modifier = Modifier.fillMaxWidth()) {
        Column(modifier = Modifier.padding(16.dp), verticalArrangement = Arrangement.spacedBy(12.dp)) {
            Text("Settings", style = MaterialTheme.typography.titleMedium)
            SettingsRow(
                label = "Run in background",
                checked = state.runInBackground,
                onCheckedChange = onToggleBackground,
            )
            var apiKey by remember(state.curseForgeApiKey) {
                mutableStateOf(state.curseForgeApiKey)
            }
            OutlinedTextField(
                value = apiKey,
                onValueChange = { apiKey = it; onCurseForgeApiKey(it) },
                label = { Text("CurseForge API key") },
                modifier = Modifier.fillMaxWidth(),
            )
            Text(
                "Modrinth works without a key. CurseForge requires your own key. Get one free at console.curseforge.com → API Keys.",
                style = MaterialTheme.typography.bodySmall,
            )
            Button(onClick = onClose, modifier = Modifier.fillMaxWidth()) { Text("Close") }
        }
    }
}

@Composable
fun SettingsRow(label: String, checked: Boolean, onCheckedChange: (Boolean) -> Unit) {
    Row(
        modifier = Modifier.fillMaxWidth(),
        horizontalArrangement = Arrangement.SpaceBetween,
        verticalAlignment = Alignment.CenterVertically,
    ) {
        Text(label)
        Switch(checked = checked, onCheckedChange = onCheckedChange)
    }
}

@Composable
fun FooterText() {
    Text(
        "Powered by CFR · AGPLv3 · github.com/NX-developer/NX-Un-Minecraft-Java-mod",
        style = MaterialTheme.typography.labelSmall,
        modifier = Modifier.padding(top = 16.dp),
    )
}
