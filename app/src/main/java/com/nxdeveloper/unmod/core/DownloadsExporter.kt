package com.nxdeveloper.unmod.core

import android.content.ContentValues
import android.content.Context
import android.net.Uri
import android.os.Build
import android.os.Environment
import android.provider.MediaStore
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import java.io.File

/** Exports the finished sources ZIP into the shared Downloads/NX-Un-Mod folder. */
class DownloadsExporter(private val context: Context) {

    data class ExportedFile(val uri: Uri, val displayPath: String)

    suspend fun export(sourceZip: File, displayName: String): Result<ExportedFile> =
        withContext(Dispatchers.IO) {
            runCatching {
                if (Build.VERSION.SDK_INT < 29) {
                    exportToLegacyDownloads(sourceZip, displayName)
                } else {
                    exportViaMediaStore(sourceZip, displayName)
                }
            }
        }

    private fun exportToLegacyDownloads(sourceZip: File, displayName: String): ExportedFile {
        val dir = File(Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS), "NX-Un-Mod")
        dir.mkdirs()
        val target = File(dir, displayName)
        sourceZip.copyTo(target, overwrite = true)
        return ExportedFile(Uri.fromFile(target), "Downloads/NX-Un-Mod/$displayName")
    }

    private fun exportViaMediaStore(sourceZip: File, displayName: String): ExportedFile {
        val resolver = context.contentResolver
        val collection = MediaStore.Downloads.getContentUri("external_primary")
        val values = ContentValues().apply {
            put(MediaStore.Downloads.DISPLAY_NAME, displayName)
            put(MediaStore.Downloads.MIME_TYPE, "application/zip")
            put(MediaStore.Downloads.RELATIVE_PATH, "${Environment.DIRECTORY_DOWNLOADS}/NX-Un-Mod")
            put(MediaStore.Downloads.IS_PENDING, 1)
        }
        val itemUri = resolver.insert(collection, values)
            ?: throw IllegalStateException("Failed to create MediaStore entry")

        resolver.openOutputStream(itemUri)?.use { output ->
            sourceZip.inputStream().use { input -> input.copyTo(output) }
        } ?: throw IllegalStateException("Failed to open output stream for $itemUri")

        val doneValues = ContentValues().apply { put(MediaStore.Downloads.IS_PENDING, 0) }
        resolver.update(itemUri, doneValues, null, null)

        return ExportedFile(itemUri, "Downloads/NX-Un-Mod/$displayName")
    }
}
