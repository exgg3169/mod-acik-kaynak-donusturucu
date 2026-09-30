package com.nxdeveloper.unmod

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.viewModels
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.Surface
import androidx.compose.runtime.CompositionLocalProvider
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import com.nxdeveloper.unmod.ui.LanguageScreen
import com.nxdeveloper.unmod.ui.LocalStrings
import com.nxdeveloper.unmod.ui.MainScreen
import com.nxdeveloper.unmod.ui.MainViewModel
import com.nxdeveloper.unmod.ui.stringsFor
import com.nxdeveloper.unmod.ui.theme.NxUnModTheme

class MainActivity : ComponentActivity() {

    private val viewModel: MainViewModel by viewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            NxUnModTheme {
                Surface(modifier = Modifier.fillMaxSize()) {
                    val languageCode by viewModel.languageCode.collectAsState()
                    if (languageCode == null) {
                        LanguageScreen(onChoose = { code -> viewModel.setLanguageCode(code) })
                    } else {
                        CompositionLocalProvider(LocalStrings provides stringsFor(languageCode)) {
                            MainScreen(viewModel)
                        }
                    }
                }
            }
        }
    }
}
