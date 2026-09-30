package com.nxdeveloper.unmod.ui.theme

import android.os.Build
import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.darkColorScheme
import androidx.compose.material3.dynamicDarkColorScheme
import androidx.compose.material3.dynamicLightColorScheme
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext

private val DarkColors = darkColorScheme(
    primary = NxCyan80,
    secondary = NxPurple80,
    tertiary = NxAmber80,
    background = Color(0xFF01020B),
    surface = Color(0xFF0F1020),
)

private val LightColors = lightColorScheme(
    primary = NxCyan40,
    secondary = NxPurple40,
    tertiary = NxAmber40,
)

@Composable
fun NxUnModTheme(
    darkTheme: Boolean = isSystemInDarkTheme(),
    // The original app's branding (icon, name) is dark-themed; default to the app's own
    // cyan/purple palette instead of the device wallpaper's dynamic colors.
    dynamicColor: Boolean = false,
    content: @Composable () -> Unit,
) {
    val colorScheme = when {
        dynamicColor && Build.VERSION.SDK_INT >= 31 -> {
            val context = LocalContext.current
            if (darkTheme) dynamicDarkColorScheme(context) else dynamicLightColorScheme(context)
        }
        darkTheme -> DarkColors
        else -> LightColors
    }

    MaterialTheme(
        colorScheme = colorScheme,
        typography = Typography,
        content = content,
    )
}
