package com.nxdeveloper.unmod.ui

import android.app.Application
import android.net.Uri
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.viewModelScope
import com.nxdeveloper.unmod.core.DecompileEngine
import com.nxdeveloper.unmod.core.DecompileOrchestrator
import com.nxdeveloper.unmod.core.JarDecompiler
import com.nxdeveloper.unmod.core.SettingsStore
import com.nxdeveloper.unmod.core.mods.ModBrowserRepository
import com.nxdeveloper.unmod.core.mods.ModFile
import com.nxdeveloper.unmod.core.mods.ModHit
import com.nxdeveloper.unmod.core.mods.ModLoader
import com.nxdeveloper.unmod.core.mods.ModProvider
import kotlinx.coroutines.Job
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.combine
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch

class MainViewModel(application: Application) : AndroidViewModel(application) {

    data class UiState(
        val pickedUri: Uri? = null,
        val pickedDisplayName: String = "",
        val pickedSizeBytes: Long = 0,
        val isRunning: Boolean = false,
        val stage: String = "",
        val progress: Float = 0f,
        val detail: String = "",
        val outputUri: Uri? = null,
        val outputDisplayPath: String? = null,
        val outputDisplayName: String? = null,
        val stats: JarDecompiler.Stats? = null,
        val outputSizeBytes: Long = 0,
        val errorMessage: String? = null,
        val runInBackground: Boolean = false,
        val showSettings: Boolean = false,
    )

    data class BrowserState(
        val provider: ModProvider = ModProvider.MODRINTH,
        val query: String = "",
        val loader: ModLoader = ModLoader.ANY,
        val mcVersion: String = "",
        val page: Int = 0,
        val pageSize: Int = 20,
        val totalCount: Int = 0,
        val hasNext: Boolean = false,
        val hasPrev: Boolean = false,
        val searching: Boolean = false,
        val hits: List<ModHit> = emptyList(),
        val selectedMod: ModHit? = null,
        val loadingFiles: Boolean = false,
        val files: List<ModFile> = emptyList(),
        val error: String? = null,
    ) {
        val totalPages: Int
            get() = if (pageSize <= 0) 1 else ((totalCount + pageSize - 1) / pageSize).coerceAtLeast(1)
    }

    private val settings = SettingsStore.get(application)
    private val repository = ModBrowserRepository()

    private val _localState = MutableStateFlow(UiState())
    val state: StateFlow<UiState> = _localState.asStateFlow()

    private val _browser = MutableStateFlow(BrowserState())
    val browser: StateFlow<BrowserState> = _browser.asStateFlow()

    private var searchJob: Job? = null
    private var filesJob: Job? = null

    init {
        viewModelScope.launch {
            combine(DecompileEngine.state, DecompileEngine.isRunning, settings.runInBackground) { state, running, background ->
                Triple(state, running, background)
            }.collect { (engineState, running, background) ->
                applyEngineState(engineState, running, background)
            }
        }
    }

    // ---- File pipeline ----

    fun onFilePicked(uri: Uri, displayName: String, sizeBytes: Long) {
        _localState.update { it.copy(pickedUri = uri, pickedDisplayName = displayName, pickedSizeBytes = sizeBytes, errorMessage = "") }
    }

    fun clearPick() {
        _localState.update { it.copy(pickedUri = null, pickedDisplayName = "") }
    }

    fun startDecompile() {
        val uri = state.value.pickedUri ?: return
        if (state.value.isRunning) return
        DecompileEngine.startFromUri(getApplication(), uri, settings.runInBackground.value)
    }

    fun downloadAndDecompile(file: ModFile) {
        val url = file.downloadUrl
        if (url.isNullOrBlank()) {
            _browser.update { it.copy(error = "This file has no public download URL (author disabled third-party downloads).") }
            return
        }
        if (state.value.isRunning) return
        closeModFiles()
        DecompileEngine.startFromUrl(getApplication(), url, file.fileName, settings.runInBackground.value)
    }

    fun cancel() {
        DecompileEngine.cancel(getApplication())
    }

    fun reset() {
        DecompileEngine.reset()
        _localState.value = UiState(runInBackground = settings.runInBackground.value)
    }

    // ---- Settings ----

    fun openSettings() {
        _localState.update { it.copy(showSettings = true) }
    }

    fun closeSettings() {
        _localState.update { it.copy(showSettings = false) }
    }

    fun setRunInBackground(value: Boolean) {
        settings.setRunInBackground(value)
    }

    // ---- Mod browser ----

    fun setProvider(provider: ModProvider) {
        _browser.update { it.copy(provider = provider) }
    }

    fun setQuery(query: String) {
        _browser.update { it.copy(query = query) }
    }

    fun setLoader(loader: ModLoader) {
        _browser.update { it.copy(loader = loader) }
    }

    fun setMcVersion(version: String) {
        _browser.update { it.copy(mcVersion = version) }
    }

    fun search() = runSearch(0)

    fun nextPage() {
        val current = browser.value
        if (current.hasNext) runSearch(current.page + 1)
    }

    fun prevPage() {
        val current = browser.value
        if (current.hasPrev) runSearch(current.page - 1)
    }

    fun firstPage() {
        if (browser.value.page != 0) runSearch(0)
    }

    fun lastPage() {
        val target = (browser.value.totalPages - 1).coerceAtLeast(0)
        if (browser.value.page != target) runSearch(target)
    }

    private fun runSearch(page: Int) {
        val current = browser.value
        if (current.searching) return
        searchJob?.cancel()
        _browser.update { it.copy(searching = true, page = page, hits = emptyList(), error = null) }
        searchJob = viewModelScope.launch {
            val result = repository.search(
                current.provider,
                current.query,
                current.loader,
                current.mcVersion,
                page * current.pageSize,
                current.pageSize,
            )
            result.onSuccess { pageResult ->
                _browser.update {
                    it.copy(
                        searching = false,
                        hits = pageResult.hits,
                        totalCount = pageResult.totalCount,
                        hasNext = (page + 1) * it.pageSize < pageResult.totalCount,
                        hasPrev = page > 0,
                    )
                }
            }.onFailure { error ->
                _browser.update { it.copy(searching = false, error = error.message ?: "Search failed") }
            }
        }
    }

    fun selectMod(hit: ModHit) {
        filesJob?.cancel()
        _browser.update { it.copy(selectedMod = hit, loadingFiles = true, files = emptyList()) }
        val snapshot = browser.value
        filesJob = viewModelScope.launch {
            val result = repository.listFiles(hit.provider, hit.id, snapshot.loader, snapshot.mcVersion)
            result.onSuccess { files ->
                _browser.update { it.copy(loadingFiles = false, files = files) }
            }.onFailure { error ->
                _browser.update { it.copy(loadingFiles = false, error = error.message ?: "Failed to load files") }
            }
        }
    }

    fun closeModFiles() {
        filesJob?.cancel()
        _browser.update { it.copy(selectedMod = null, files = emptyList()) }
    }

    // ---- Engine state -> UI state ----

    private fun applyEngineState(engineState: DecompileOrchestrator.State, running: Boolean, runInBackground: Boolean) {
        _localState.update { current ->
            val base = current.copy(isRunning = running, runInBackground = runInBackground)
            when (engineState) {
                is DecompileOrchestrator.State.Idle -> {
                    val stage = if (base.stage == "Done" || base.stage == "Failed") base.stage else ""
                    val progress = if (base.stage == "Done") 1f else 0f
                    base.copy(stage = stage, progress = progress)
                }
                is DecompileOrchestrator.State.Downloading -> base.copy(
                    stage = "Downloading",
                    progress = if (engineState.total > 0) (engineState.downloaded.toFloat() / engineState.total).coerceIn(0f, 1f) else 0f,
                    detail = engineState.displayName + "  " + formatBytes(engineState.downloaded) + (if (engineState.total > 0) " / " + formatBytes(engineState.total) else ""),
                )
                is DecompileOrchestrator.State.Loading -> base.copy(
                    stage = "Loading",
                    progress = if (engineState.total > 0) (engineState.copied.toFloat() / engineState.total).coerceIn(0f, 1f) else 0f,
                    detail = formatBytes(engineState.copied) + (if (engineState.total > 0) " / " + formatBytes(engineState.total) else ""),
                )
                is DecompileOrchestrator.State.Decompiling -> base.copy(
                    stage = "Decompiling",
                    progress = if (engineState.total > 0) engineState.current.toFloat() / engineState.total else 0f,
                    detail = if (engineState.total > 0) "${engineState.current} / ${engineState.total} - ${engineState.currentClass}" else "Preparing...",
                )
                is DecompileOrchestrator.State.Zipping -> base.copy(
                    stage = "Zipping",
                    progress = if (engineState.total > 0) engineState.current.toFloat() / engineState.total else 0f,
                    detail = if (engineState.total > 0) "${engineState.current} / ${engineState.total} files" else "Packing...",
                )
                is DecompileOrchestrator.State.Exporting -> base.copy(
                    stage = "Saving",
                    progress = 1f,
                    detail = "Saving ${engineState.displayName}",
                )
                is DecompileOrchestrator.State.Done -> base.copy(
                    stage = "Done",
                    progress = 1f,
                    detail = "Saved to ${engineState.displayPath}",
                    outputUri = engineState.outputUri,
                    outputDisplayPath = engineState.displayPath,
                    outputDisplayName = engineState.displayName,
                    stats = engineState.stats,
                    outputSizeBytes = engineState.outputSizeBytes,
                )
                is DecompileOrchestrator.State.Failed -> base.copy(
                    stage = "Failed",
                    detail = "Failed at ${engineState.stage}",
                    errorMessage = engineState.message,
                )
            }
        }
    }

    companion object {
        fun formatBytes(bytes: Long): String {
            if (bytes <= 0) return "0 B"
            val units = arrayOf("B", "KB", "MB", "GB")
            var value = bytes.toDouble()
            var unitIndex = 0
            while (value >= 1024 && unitIndex < units.lastIndex) {
                value /= 1024
                unitIndex++
            }
            return if (unitIndex == 0) "${bytes} ${units[0]}" else "%.1f %s".format(value, units[unitIndex])
        }
    }
}
