package com.venom.executor;

import android.Manifest;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Color;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.provider.OpenableColumns;
import android.database.Cursor;
import android.text.Spannable;
import android.text.SpannableStringBuilder;
import android.text.style.ForegroundColorSpan;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;
import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.contract.ActivityResultContracts;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import com.venom.executor.bypass.EmulatorBypass;
import com.venom.executor.bypass.SSLBypass;
import com.venom.executor.bypass.SignatureBypass;
import com.venom.executor.patcher.ApkPatcher;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class MainActivity extends AppCompatActivity {

    private static final String TARGET_LIB   = "/data/local/tmp/libvenom_payload.so";
    private static final String SCRIPT_TMP   = "/data/local/tmp/custom-4.lua";
    private static final String SCRIPT_ASSET = "scripts/custom-4.lua";

    private EditText   scriptEditor;
    private TextView   outputArea;
    private ScrollView outputScroll;

    private Button executeBtn, injectBtn, resetBtn, pidBtn, loadScriptBtn;
    private Button patchApkBtn;
    private LinearLayout patcherPanel;

    private boolean rootAvailable = false;
    private Uri selectedApkUri = null;

    private final ExecutorService executor = Executors.newSingleThreadExecutor();
    private final Handler mainHandler = new Handler(Looper.getMainLooper());

    private final ActivityResultLauncher<String> apkPickerLauncher =
        registerForActivityResult(new ActivityResultContracts.GetContent(), uri -> {
            if (uri != null) {
                selectedApkUri = uri;
                String name = getFileName(uri);
                appendOutput("[PATCH] APK seçildi: " + name, Color.CYAN);
                patchApkBtn.setEnabled(true);
            }
        });

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        scriptEditor  = findViewById(R.id.scriptEditor);
        outputArea    = findViewById(R.id.outputArea);
        outputScroll  = findViewById(R.id.outputScroll);
        executeBtn    = findViewById(R.id.executeBtn);
        injectBtn     = findViewById(R.id.injectBtn);
        resetBtn      = findViewById(R.id.resetBtn);
        pidBtn        = findViewById(R.id.pidBtn);
        loadScriptBtn = findViewById(R.id.loadScriptBtn);
        patcherPanel  = findViewById(R.id.patcherPanel);
        patchApkBtn   = findViewById(R.id.patchApkBtn);

        requestPermissions();
        installBypasses();
        LuaEngine.init();

        rootAvailable = LuaEngine.isRootAvailable();

        appendOutput("[VENOM] Executor v1.2 — Blockymods Edition", Color.parseColor("#FF0000"));
        appendOutput("[TARGET] com.sandboxol.blockymods 3.29.3", Color.CYAN);
        appendOutput("[ROOT] " + (rootAvailable ? "Mevcut — Inject modu aktif" : "Yok — Patcher modu aktif"),
                     rootAvailable ? Color.GREEN : Color.YELLOW);
        appendOutput("[BYPASS] root/anti-debug/nesec/pglarmor/ssl — active", Color.YELLOW);

        if (!rootAvailable) {
            injectBtn.setEnabled(false);
            injectBtn.setAlpha(0.4f);
            patcherPanel.setVisibility(View.VISIBLE);
            appendOutput("[PATCH] APK seçip Blockymods'u patch et, tekrar kur", Color.parseColor("#FFA500"));
        } else {
            patcherPanel.setVisibility(View.GONE);
        }

        extractScriptAsync(false);

        loadScriptBtn.setOnClickListener(v -> {
            appendOutput("[SCRIPT] Extracting custom-4.lua from APK assets...", Color.YELLOW);
            extractScriptAsync(true);
        });

        executeBtn.setOnClickListener(v -> {
            String script = scriptEditor.getText().toString().trim();
            if (script.isEmpty()) {
                appendOutput("[!] Script boş", Color.RED);
                return;
            }
            appendOutput("[LUA] Executing...", Color.GRAY);
            String result = LuaEngine.execute(script);
            appendOutput(result, result.startsWith("Lua error") ? Color.RED : Color.WHITE);
        });

        injectBtn.setOnClickListener(v -> {
            executor.execute(() -> {
                mainHandler.post(() -> appendOutput("[INJ] Preparing...", Color.YELLOW));
                if (!LuaEngine.scriptExists(SCRIPT_TMP)) {
                    boolean ok = LuaEngine.extractAsset(this, SCRIPT_ASSET, SCRIPT_TMP);
                    mainHandler.post(() -> appendOutput(ok
                        ? "[SCRIPT] custom-4.lua → " + SCRIPT_TMP
                        : "[SCRIPT] Extract başarısız", ok ? Color.GREEN : Color.RED));
                    if (!ok) return;
                }
                if (!new File(TARGET_LIB).exists()) {
                    mainHandler.post(() -> appendOutput(
                        "[!] " + TARGET_LIB + " yok\nadb push libvenom_payload.so /data/local/tmp/",
                        Color.RED));
                    return;
                }
                mainHandler.post(() -> appendOutput("[INJ] Injecting " + TARGET_LIB + "...", Color.YELLOW));
                String result = LuaEngine.injectIntoGame(TARGET_LIB);
                int color = result.startsWith("[OK]") ? Color.GREEN : Color.RED;
                mainHandler.post(() -> {
                    appendOutput(result, color);
                    if (result.startsWith("[OK]")) {
                        appendOutput("[LUA] custom-4.lua Blockymods içinde çalışıyor", Color.GREEN);
                    }
                });
            });
        });

        resetBtn.setOnClickListener(v -> {
            LuaEngine.resetState();
            appendOutput("[LUA] State reset", Color.CYAN);
        });

        pidBtn.setOnClickListener(v -> appendOutput("[PID] Blockymods: " + LuaEngine.getTargetPid(), Color.CYAN));

        findViewById(R.id.selectApkBtn).setOnClickListener(v -> apkPickerLauncher.launch("application/vnd.android.package-archive"));

        patchApkBtn.setOnClickListener(v -> {
            if (selectedApkUri == null) {
                appendOutput("[!] Önce APK seç", Color.RED);
                return;
            }
            patchApkBtn.setEnabled(false);
            executor.execute(() -> {
                try {
                    File inputApk = copyUriToTemp(selectedApkUri);
                    File outputApk = new File(getExternalFilesDir(null), "Blockymods_Patched.apk");

                    ApkPatcher.patch(this, inputApk, outputApk, new ApkPatcher.Progress() {
                        @Override public void onProgress(String step) {
                            mainHandler.post(() -> appendOutput("[PATCH] " + step, Color.CYAN));
                        }
                        @Override public void onError(String error) {
                            mainHandler.post(() -> {
                                appendOutput("[PATCH] HATA: " + error, Color.RED);
                                patchApkBtn.setEnabled(true);
                            });
                        }
                        @Override public void onDone(File output) {
                            mainHandler.post(() -> {
                                appendOutput("[PATCH] Tamamlandı: " + output.getAbsolutePath(), Color.GREEN);
                                appendOutput("[PATCH] APK kurulumunu başlatıyor...", Color.YELLOW);
                                patchApkBtn.setEnabled(true);
                                installApk(output);
                            });
                        }
                    });
                } catch (Exception e) {
                    mainHandler.post(() -> {
                        appendOutput("[PATCH] Kopyalama hatası: " + e.getMessage(), Color.RED);
                        patchApkBtn.setEnabled(true);
                    });
                }
            });
        });
    }

    private void installApk(File apk) {
        Uri uri = androidx.core.content.FileProvider.getUriForFile(
            this, getPackageName() + ".provider", apk);
        Intent intent = new Intent(Intent.ACTION_VIEW);
        intent.setDataAndType(uri, "application/vnd.android.package-archive");
        intent.setFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION | Intent.FLAG_ACTIVITY_NEW_TASK);
        startActivity(intent);
    }

    private File copyUriToTemp(Uri uri) throws IOException {
        File tmp = new File(getCacheDir(), "input.apk");
        try (InputStream in = getContentResolver().openInputStream(uri);
             FileOutputStream out = new FileOutputStream(tmp)) {
            byte[] buf = new byte[8192];
            int len;
            while ((len = in.read(buf)) != -1) out.write(buf, 0, len);
        }
        return tmp;
    }

    private String getFileName(Uri uri) {
        Cursor cursor = getContentResolver().query(uri, null, null, null, null);
        if (cursor != null) {
            int idx = cursor.getColumnIndex(OpenableColumns.DISPLAY_NAME);
            if (idx >= 0 && cursor.moveToFirst()) {
                String name = cursor.getString(idx);
                cursor.close();
                return name;
            }
            cursor.close();
        }
        return uri.getLastPathSegment();
    }

    private void extractScriptAsync(boolean verbose) {
        executor.execute(() -> {
            if (!verbose && LuaEngine.scriptExists(SCRIPT_TMP)) {
                mainHandler.post(() -> appendOutput("[SCRIPT] custom-4.lua mevcut: " + SCRIPT_TMP, Color.GRAY));
                return;
            }
            boolean ok = LuaEngine.extractAsset(this, SCRIPT_ASSET, SCRIPT_TMP);
            mainHandler.post(() -> appendOutput(ok
                ? "[SCRIPT] custom-4.lua → " + SCRIPT_TMP + " ✓"
                : "[SCRIPT] Extract başarısız\nalternatif: adb push custom-4.lua /data/local/tmp/",
                ok ? Color.GREEN : Color.RED));
        });
    }

    private void installBypasses() {
        try {
            EmulatorBypass.spoof();
            SSLBypass.install();
            SignatureBypass.install(this);
        } catch (Exception e) {
            appendOutput("[BYPASS] Java bypass error: " + e.getMessage(), Color.RED);
        }
    }

    private void requestPermissions() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            String[] perms = {
                Manifest.permission.READ_EXTERNAL_STORAGE,
                Manifest.permission.WRITE_EXTERNAL_STORAGE
            };
            for (String p : perms) {
                if (ContextCompat.checkSelfPermission(this, p) != PackageManager.PERMISSION_GRANTED) {
                    ActivityCompat.requestPermissions(this, perms, 100);
                    break;
                }
            }
        }
    }

    private void appendOutput(String text, int color) {
        SpannableStringBuilder sb = new SpannableStringBuilder(text + "\n");
        sb.setSpan(new ForegroundColorSpan(color), 0, sb.length(), Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
        outputArea.append(sb);
        outputScroll.post(() -> outputScroll.fullScroll(View.FOCUS_DOWN));
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        executor.shutdownNow();
    }
}
