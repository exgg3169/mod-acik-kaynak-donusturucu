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

    // null means "not chosen yet" — the app shows the language picker until this is set.
    private val _languageCode = MutableStateFlow(prefs.getString(KEY_LANGUAGE, null))
    val languageCode: StateFlow<String?> = _languageCode.asStateFlow()

    fun setRunInBackground(value: Boolean) {
        prefs.edit().putBoolean(KEY_RUN_IN_BACKGROUND, value).apply()
        _runInBackground.value = value
    }

    fun setLanguageCode(value: String) {
        prefs.edit().putString(KEY_LANGUAGE, value).apply()
        _languageCode.value = value
    }

    companion object {
        private const val KEY_RUN_IN_BACKGROUND = "run_in_background"
        private const val KEY_LANGUAGE = "language_code"

        @Volatile
        private var instance: SettingsStore? = null

        fun get(context: Context): SettingsStore =
            instance ?: synchronized(this) {
                instance ?: SettingsStore(context).also { instance = it }
            }
    }
}
