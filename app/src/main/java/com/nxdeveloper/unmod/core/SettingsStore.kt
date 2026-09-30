package com.nxdeveloper.unmod.core

import android.content.Context
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow

/** Small SharedPreferences-backed settings store (singleton per process). */
class SettingsStore private constructor(context: Context) {

    private val prefs = context.applicationContext.getSharedPreferences("nx_uninstaller_settings", Context.MODE_PRIVATE)

    private val _runInBackground = MutableStateFlow(prefs.getBoolean(KEY_RUN_IN_BACKGROUND, false))
    val runInBackground: StateFlow<Boolean> = _runInBackground.asStateFlow()

    fun setRunInBackground(value: Boolean) {
        prefs.edit().putBoolean(KEY_RUN_IN_BACKGROUND, value).apply()
        _runInBackground.value = value
    }

    companion object {
        private const val KEY_RUN_IN_BACKGROUND = "run_in_background"

        @Volatile
        private var instance: SettingsStore? = null

        fun get(context: Context): SettingsStore =
            instance ?: synchronized(this) {
                instance ?: SettingsStore(context).also { instance = it }
            }
    }
}
