package com.nxdeveloper.unmod.core

import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.IBinder
import androidx.core.app.NotificationCompat
import androidx.core.app.ServiceCompat
import com.nxdeveloper.unmod.MainActivity
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.cancel
import kotlinx.coroutines.launch

/** Foreground service that keeps a decompile job running while the app is backgrounded. */
class DecompileService : Service() {

    private val serviceScope = CoroutineScope(SupervisorJob() + Dispatchers.Default)
    private var workJob: Job? = null
    private var lastUpdateMs = 0L

    override fun onCreate() {
        super.onCreate()
        createNotificationChannel()
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        when (intent?.action) {
            DecompileEngine.ACTION_START -> handleStart(intent)
            DecompileEngine.ACTION_CANCEL -> handleCancel()
            null -> stopSelf()
        }
        return START_REDELIVER_INTENT
    }

    override fun onBind(intent: Intent?): IBinder? = null

    override fun onDestroy() {
        workJob?.cancel()
        serviceScope.cancel()
        super.onDestroy()
    }

    private fun handleStart(intent: Intent) {
        startForegroundCompat(buildNotification("Starting", "Preparing pipeline", null, ongoing = true))

        val uri: Uri? = if (Build.VERSION.SDK_INT < 33) {
            intent.getParcelableExtra(DecompileEngine.EXTRA_URI)
        } else {
            intent.getParcelableExtra(DecompileEngine.EXTRA_URI, Uri::class.java)
        }
        val url = intent.getStringExtra(DecompileEngine.EXTRA_URL)
        val name = intent.getStringExtra(DecompileEngine.EXTRA_NAME) ?: "mod.jar"

        val flowFactory: (DecompileOrchestrator) -> kotlinx.coroutines.flow.Flow<DecompileOrchestrator.State> = when {
            uri != null -> { orch -> orch.run(uri) }
            url != null -> { orch -> orch.runFromUrl(url, name) }
            else -> {
                ServiceCompat.stopForeground(this, ServiceCompat.STOP_FOREGROUND_REMOVE)
                stopSelf()
                return
            }
        }

        workJob?.cancel()
        workJob = serviceScope.launch {
            DecompileEngine.runFromService(applicationContext, flowFactory) { state -> updateNotification(state) }
            stopSelf()
        }
    }

    private fun handleCancel() {
        workJob?.cancel()
        workJob = null
        ServiceCompat.stopForeground(this, ServiceCompat.STOP_FOREGROUND_REMOVE)
        stopSelf()
    }

    private fun updateNotification(state: DecompileOrchestrator.State) {
        val now = System.currentTimeMillis()
        val isTerminal = state is DecompileOrchestrator.State.Done || state is DecompileOrchestrator.State.Failed
        if (!isTerminal && now - lastUpdateMs < 400) return
        lastUpdateMs = now

        var progress: Int? = null
        when (state) {
            is DecompileOrchestrator.State.Downloading -> {
                if (state.total > 0) progress = ((state.downloaded * 100) / state.total).toInt()
                notify(buildNotification("Downloading mod", state.displayName, progress, ongoing = true))
            }
            is DecompileOrchestrator.State.Loading -> {
                if (state.total > 0) progress = ((state.copied * 100) / state.total).toInt()
                val text = state.displayName.ifBlank { "Reading JAR..." }
                notify(buildNotification("Loading file", text, progress, ongoing = true))
            }
            is DecompileOrchestrator.State.Decompiling -> {
                if (state.total > 0) progress = (state.current * 100) / state.total
                notify(buildNotification("Decompiling", "${state.current}/${state.total}  ${state.currentClass}", progress, ongoing = true))
            }
            is DecompileOrchestrator.State.Zipping -> {
                if (state.total > 0) progress = (state.current * 100) / state.total
                notify(buildNotification("Zipping sources", "${state.current}/${state.total} files", progress, ongoing = true))
            }
            is DecompileOrchestrator.State.Exporting -> {
                notify(buildNotification("Saving to Downloads", state.displayName, null, ongoing = true))
            }
            is DecompileOrchestrator.State.Done -> {
                notificationManager.notify(NOTIFICATION_ID_RESULT, buildCompletionNotification(state))
                ServiceCompat.stopForeground(this, ServiceCompat.STOP_FOREGROUND_REMOVE)
            }
            is DecompileOrchestrator.State.Failed -> {
                notificationManager.notify(NOTIFICATION_ID_RESULT, buildFailureNotification(state))
                ServiceCompat.stopForeground(this, ServiceCompat.STOP_FOREGROUND_REMOVE)
            }
            is DecompileOrchestrator.State.Idle -> Unit
        }
    }

    private fun notify(notification: Notification) {
        notificationManager.notify(NOTIFICATION_ID_PROGRESS, notification)
    }

    private fun startForegroundCompat(notification: Notification) {
        if (Build.VERSION.SDK_INT < 29) {
            startForeground(NOTIFICATION_ID_PROGRESS, notification)
        } else {
            startForeground(NOTIFICATION_ID_PROGRESS, notification, android.content.pm.ServiceInfo.FOREGROUND_SERVICE_TYPE_DATA_SYNC)
        }
    }

    private fun buildNotification(title: String, text: String, progress: Int?, ongoing: Boolean): Notification {
        val openIntent = Intent(this, MainActivity::class.java).apply {
            flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TASK
        }
        val openPending = PendingIntent.getActivity(this, 0, openIntent, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
        val cancelIntent = Intent(this, DecompileService::class.java).apply { action = DecompileEngine.ACTION_CANCEL }
        val cancelPending = PendingIntent.getService(this, 1, cancelIntent, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)

        val builder = NotificationCompat.Builder(this, CHANNEL_ID)
            .setSmallIcon(android.R.drawable.stat_sys_download)
            .setContentTitle(title)
            .setContentText(text)
            .setStyle(NotificationCompat.BigTextStyle().bigText(text))
            .setContentIntent(openPending)
            .setOngoing(ongoing)
            .setOnlyAlertOnce(true)
            .setPriority(NotificationCompat.PRIORITY_LOW)
            .setCategory(NotificationCompat.CATEGORY_PROGRESS)
            .addAction(android.R.drawable.ic_menu_close_clear_cancel, "Cancel", cancelPending)

        if (progress == null) builder.setProgress(0, 0, true) else builder.setProgress(100, progress, false)
        return builder.build()
    }

    private fun buildCompletionNotification(state: DecompileOrchestrator.State.Done): Notification {
        val viewIntent = Intent(Intent.ACTION_VIEW).apply {
            setDataAndType(state.outputUri, "application/zip")
            addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        }
        val openPending = PendingIntent.getActivity(
            this, 10, Intent.createChooser(viewIntent, "Open ZIP"),
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
        )
        val shareIntent = Intent(Intent.ACTION_SEND).apply {
            type = "application/zip"
            putExtra(Intent.EXTRA_STREAM, state.outputUri)
            addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
            addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        }
        val sharePending = PendingIntent.getActivity(
            this, 11, Intent.createChooser(shareIntent, "Share ZIP"),
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE,
        )
        val text = "${state.stats.decompiled} classes decompiled, saved to ${state.displayPath}"
        return NotificationCompat.Builder(this, CHANNEL_ID)
            .setSmallIcon(android.R.drawable.stat_sys_download_done)
            .setContentTitle("Decompile complete")
            .setContentText(text)
            .setStyle(NotificationCompat.BigTextStyle().bigText(text))
            .setContentIntent(openPending)
            .setAutoCancel(true)
            .setOngoing(false)
            .setPriority(NotificationCompat.PRIORITY_DEFAULT)
            .setCategory(NotificationCompat.CATEGORY_STATUS)
            .addAction(android.R.drawable.ic_menu_view, "Open", openPending)
            .addAction(android.R.drawable.ic_menu_share, "Share", sharePending)
            .build()
    }

    private fun buildFailureNotification(state: DecompileOrchestrator.State.Failed): Notification {
        val openIntent = Intent(this, MainActivity::class.java)
        val openPending = PendingIntent.getActivity(this, 20, openIntent, PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
        val text = "Failed at ${state.stage}: ${state.message}"
        return NotificationCompat.Builder(this, CHANNEL_ID)
            .setSmallIcon(android.R.drawable.stat_notify_error)
            .setContentTitle("Decompile failed")
            .setContentText(text)
            .setStyle(NotificationCompat.BigTextStyle().bigText(text))
            .setContentIntent(openPending)
            .setAutoCancel(true)
            .setOngoing(false)
            .setPriority(NotificationCompat.PRIORITY_HIGH)
            .build()
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= 26) {
            if (notificationManager.getNotificationChannel(CHANNEL_ID) == null) {
                val channel = NotificationChannel(CHANNEL_ID, "Decompile progress", NotificationManager.IMPORTANCE_LOW).apply {
                    description = "Background progress for NX Uninstaller decompile jobs"
                    setShowBadge(false)
                }
                notificationManager.createNotificationChannel(channel)
            }
        }
    }

    private val notificationManager: NotificationManager
        get() = getSystemService(NOTIFICATION_SERVICE) as NotificationManager

    companion object {
        private const val CHANNEL_ID = "decompile_progress"
        private const val NOTIFICATION_ID_PROGRESS = 1001
        private const val NOTIFICATION_ID_RESULT = 1002
    }
}
