package com.opensource.moddecompiler

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.view.View
import androidx.activity.result.contract.ActivityResultContracts
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.FileProvider
import androidx.lifecycle.lifecycleScope
import com.opensource.moddecompiler.databinding.ActivityMainBinding
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import org.jetbrains.java.decompiler.main.decompiler.DecompilerRunner
import org.jetbrains.java.decompiler.main.extern.IFernflowerLogger
import org.jetbrains.java.decompiler.main.extern.IFernflowerPreferences
import java.io.File

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding

    private var pickedJarUri: Uri? = null
    private var lastOutputFile: File? = null

    private val pickJarLauncher =
        registerForActivityResult(ActivityResultContracts.OpenDocument()) { uri ->
            if (uri != null) {
                pickedJarUri = uri
                binding.tvSelectedFile.text = displayNameOf(uri)
                binding.btnDecompile.isEnabled = true
                binding.btnShare.isEnabled = false
                binding.btnSave.isEnabled = false
                lastOutputFile = null
            }
        }

    private val saveResultLauncher =
        registerForActivityResult(ActivityResultContracts.CreateDocument("application/zip")) { uri ->
            val src = lastOutputFile
            if (uri != null && src != null) {
                contentResolver.openOutputStream(uri)?.use { out ->
                    src.inputStream().use { it.copyTo(out) }
                }
                appendLog("Kaydedildi: $uri")
            }
        }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        binding.btnPickJar.setOnClickListener {
            pickJarLauncher.launch(arrayOf("application/java-archive", "application/zip", "application/octet-stream", "*/*"))
        }

        binding.btnDecompile.setOnClickListener { decompileSelected() }
    }

    private fun displayNameOf(uri: Uri): String {
        var name = uri.lastPathSegment ?: uri.toString()
        contentResolver.query(uri, null, null, null, null)?.use { cursor ->
            val idx = cursor.getColumnIndex(android.provider.OpenableColumns.DISPLAY_NAME)
            if (idx >= 0 && cursor.moveToFirst()) {
                name = cursor.getString(idx)
            }
        }
        return name
    }

    private fun appendLog(message: String) {
        runOnUiThread { binding.tvLog.append("$message\n") }
    }

    private fun setBusy(busy: Boolean) {
        binding.progressBar.visibility = if (busy) View.VISIBLE else View.GONE
        binding.btnDecompile.isEnabled = !busy
        binding.btnPickJar.isEnabled = !busy
    }

    private fun decompileSelected() {
        val uri = pickedJarUri ?: return
        binding.tvLog.text = ""
        binding.btnShare.isEnabled = false
        binding.btnSave.isEnabled = false
        setBusy(true)

        lifecycleScope.launch(Dispatchers.IO) {
            try {
                val workDir = File(cacheDir, "decompile_work").apply {
                    deleteRecursively()
                    mkdirs()
                }
                val inputFile = File(workDir, "input.jar")
                contentResolver.openInputStream(uri)?.use { input ->
                    inputFile.outputStream().use { output -> input.copyTo(output) }
                } ?: throw IllegalStateException("Dosya okunamadı")

                appendLog("Mod dosyası hazırlandı (${inputFile.length()} bayt)")
                appendLog("Vineflower ${vineflowerVersion()} ile dönüştürme başlıyor…")

                val outDir = File(workDir, "output").apply { mkdirs() }

                val logger = object : IFernflowerLogger() {
                    override fun writeMessage(message: String, severity: Severity) {
                        appendLog("[${severity.prefix}] $message")
                    }

                    override fun writeMessage(message: String, severity: Severity, t: Throwable?) {
                        appendLog("[${severity.prefix}] $message${t?.let { " — ${it.message}" } ?: ""}")
                    }
                }

                // Android has no "jrt:" NIO filesystem provider, so Vineflower's default
                // attempt to add the running JVM's own runtime as a library crashes with
                // ProviderNotFoundException. Not needed for straightforward decompilation.
                val options = mapOf(IFernflowerPreferences.INCLUDE_JAVA_RUNTIME to "0")
                val decompiler = DecompilerRunner(outDir, options, logger)
                decompiler.addSource(inputFile)
                decompiler.decompileContext()

                val produced = outDir.listFiles()?.firstOrNull { it.extension == "jar" || it.extension == "zip" }

                withContext(Dispatchers.Main) {
                    setBusy(false)
                    if (produced != null) {
                        lastOutputFile = produced
                        appendLog("\nTamamlandı: ${produced.name} (${produced.length()} bayt)")
                        binding.btnShare.isEnabled = true
                        binding.btnSave.isEnabled = true
                        binding.btnShare.setOnClickListener { shareResult(produced) }
                        binding.btnSave.setOnClickListener {
                            saveResultLauncher.launch("${inputFile.nameWithoutExtension}-kaynak.zip")
                        }
                    } else {
                        appendLog("\nÇıktı üretilemedi. Günlüğü kontrol edin.")
                    }
                }
            } catch (e: Exception) {
                withContext(Dispatchers.Main) {
                    setBusy(false)
                    appendLog("\nHata: ${e.message}")
                }
            }
        }
    }

    private fun vineflowerVersion(): String =
        try {
            org.jetbrains.java.decompiler.main.decompiler.ConsoleDecompiler.version()
        } catch (e: Exception) {
            "?"
        }

    private fun shareResult(file: File) {
        val uri = FileProvider.getUriForFile(this, "$packageName.fileprovider", file)
        val intent = Intent(Intent.ACTION_SEND).apply {
            type = "application/zip"
            putExtra(Intent.EXTRA_STREAM, uri)
            addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
        }
        startActivity(Intent.createChooser(intent, getString(R.string.share)))
    }
}
