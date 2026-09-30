package com.nxdeveloper.unmod.core

import android.content.Context
import android.content.Intent
import android.net.Uri
import androidx.core.content.ContextCompat
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Job
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.cancel
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch

/**
 * Process-wide singleton that either runs the [DecompileOrchestrator] pipeline directly
 * (foreground UI job) or delegates to [DecompileService] so it survives the app being
 * backgrounded.
 */
object DecompileEngine {

    private val _state = MutableStateFlow<DecompileOrchestrator.State>(DecompileOrchestrator.State.Idle)
    val state: StateFlow<DecompileOrchestrator.State> = _state.asStateFlow()

    private val _isRunning = MutableStateFlow(false)
    val isRunning: StateFlow<Boolean> = _isRunning.asStateFlow()

    private var inProcessJob: Job? = null
    private var inProcessScope: CoroutineScope? = null
    private var serviceRunning = false

    fun startFromUri(context: Context, uri: Uri, runInBackground: Boolean) {
        if (runInBackground) {
            startServiceWith(context) { intent -> intent.putExtra(EXTRA_URI, uri) }
        } else {
            startInProcess(context) { orchestrator -> orchestrator.run(uri) }
        }
    }

    fun startFromUrl(context: Context, url: String, displayName: String, runInBackground: Boolean) {
        if (runInBackground) {
            startServiceWith(context) { intent ->
                intent.putExtra(EXTRA_URL, url)
                intent.putExtra(EXTRA_NAME, displayName)
            }
        } else {
            startInProcess(context) { orchestrator -> orchestrator.runFromUrl(url, displayName) }
        }
    }

    suspend fun runFromService(
        context: Context,
        flowFactory: (DecompileOrchestrator) -> Flow<DecompileOrchestrator.State>,
        onEachState: suspend (DecompileOrchestrator.State) -> Unit,
    ) {
        val orchestrator = DecompileOrchestrator(context.applicationContext)
        flowFactory(orchestrator).collect { onEachState(it) }
    }

    fun cancel(context: Context) {
        if (serviceRunning) {
            val intent = Intent(context, DecompileService::class.java).apply { action = ACTION_CANCEL }
            runCatching { context.applicationContext.startService(intent) }
            serviceRunning = false
        }
        cancelInternal()
        _isRunning.value = false
        _state.value = DecompileOrchestrator.State.Failed("cancel", "Cancelled by user")
    }

    fun reset() {
        cancelInternal()
        _isRunning.value = false
        serviceRunning = false
        _state.value = DecompileOrchestrator.State.Idle
    }

    private fun startInProcess(context: Context, flowFactory: (DecompileOrchestrator) -> Flow<DecompileOrchestrator.State>) {
        if (_isRunning.value) return
        cancelInternal()
        val scope = CoroutineScope(SupervisorJob())
        inProcessScope = scope
        _isRunning.value = true
        _state.value = DecompileOrchestrator.State.Idle
        inProcessJob = scope.launch {
            flowFactory(DecompileOrchestrator(context.applicationContext)).collect { state ->
                _state.value = state
                if (state is DecompileOrchestrator.State.Done || state is DecompileOrchestrator.State.Failed) {
                    _isRunning.value = false
                }
            }
        }
    }

    private fun startServiceWith(context: Context, configure: (Intent) -> Unit) {
        if (_isRunning.value) return
        cancelInternal()
        _isRunning.value = true
        serviceRunning = true
        _state.value = DecompileOrchestrator.State.Idle
        val intent = Intent(context, DecompileService::class.java).apply { action = ACTION_START }
        configure(intent)
        ContextCompat.startForegroundService(context.applicationContext, intent)
    }

    private fun cancelInternal() {
        inProcessJob?.cancel()
        inProcessJob = null
        inProcessScope?.cancel()
        inProcessScope = null
    }

    const val ACTION_START = "com.nxdeveloper.unmod.action.START"
    const val ACTION_CANCEL = "com.nxdeveloper.unmod.action.CANCEL"
    const val EXTRA_URI = "com.nxdeveloper.unmod.extra.URI"
    const val EXTRA_URL = "com.nxdeveloper.unmod.extra.URL"
    const val EXTRA_NAME = "com.nxdeveloper.unmod.extra.NAME"
}
