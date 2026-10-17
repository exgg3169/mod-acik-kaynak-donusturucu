package com.venom.executor.patcher;

import android.content.Context;
import android.util.Log;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;

public class ApkPatcher {

    private static final String TAG = "ApkPatcher";

    private static final String BOOTSTRAP_CLASS   = "com.venom.loader.BootstrapApp";
    private static final String BOOTSTRAP_ASSET   = "scripts/bootstrap.dex";
    private static final String PAYLOAD_ASSET_DIR = "lib/arm64-v8a/";
    private static final String PAYLOAD_LIB       = "libvenom_payload.so";
    private static final String SCRIPT_ASSET       = "scripts/custom-4.lua";
    private static final String SCRIPT_APK_PATH    = "assets/scripts/custom-4.lua";

    public interface Progress {
        void onProgress(String step);
        void onError(String error);
        void onDone(File output);
    }

    public static void patch(Context ctx, File inputApk, File outputApk, Progress cb) {
        new Thread(() -> {
            try {
                cb.onProgress("APK okunuyor...");
                Map<String, byte[]> entries = readZip(inputApk);

                cb.onProgress("AndroidManifest.xml patch ediliyor...");
                byte[] manifest = entries.get("AndroidManifest.xml");
                if (manifest == null) throw new IOException("AndroidManifest.xml bulunamadı");
                manifest = AXMLPatcher.patchApplicationName(manifest, BOOTSTRAP_CLASS);
                entries.put("AndroidManifest.xml", manifest);

                cb.onProgress("Bootstrap DEX ekleniyor...");
                byte[] bootstrapDex = readAsset(ctx, BOOTSTRAP_ASSET);
                if (bootstrapDex == null) throw new IOException("bootstrap.dex bulunamadı (build tarafından oluşturulmalı)");

                byte[] classesDex = entries.get("classes.dex");
                if (classesDex != null) {
                    entries.put("classes2.dex", bootstrapDex);
                } else {
                    entries.put("classes.dex", bootstrapDex);
                }

                cb.onProgress("libvenom_payload.so ekleniyor...");
                byte[] payloadSo = readPayloadSo(ctx);
                if (payloadSo != null) {
                    entries.put("lib/arm64-v8a/" + PAYLOAD_LIB, payloadSo);
                    entries.put("lib/armeabi-v7a/" + PAYLOAD_LIB, payloadSo);
                } else {
                    cb.onProgress("UYARI: libvenom_payload.so bulunamadı, atlanıyor");
                }

                cb.onProgress("custom-4.lua ekleniyor...");
                byte[] script = readAsset(ctx, SCRIPT_ASSET);
                if (script != null) {
                    entries.put(SCRIPT_APK_PATH, script);
                }

                cb.onProgress("META-INF temizleniyor...");
                entries.entrySet().removeIf(e -> e.getKey().startsWith("META-INF/"));

                cb.onProgress("Unsigned APK yazılıyor...");
                File unsignedApk = new File(outputApk.getParent(), "unsigned_tmp.apk");
                writeZip(entries, unsignedApk);

                cb.onProgress("APK imzalanıyor...");
                ApkSigner signer = ApkSigner.fromGeneratedKey();
                signer.signApk(unsignedApk, outputApk);
                unsignedApk.delete();

                cb.onProgress("Tamamlandı: " + outputApk.getAbsolutePath());
                cb.onDone(outputApk);

            } catch (Exception e) {
                Log.e(TAG, "Patch failed", e);
                cb.onError(e.getMessage() != null ? e.getMessage() : e.getClass().getSimpleName());
            }
        }, "VenomPatcher").start();
    }

    private static Map<String, byte[]> readZip(File file) throws IOException {
        Map<String, byte[]> map = new LinkedHashMap<>();
        try (ZipInputStream zin = new ZipInputStream(new FileInputStream(file))) {
            ZipEntry entry;
            while ((entry = zin.getNextEntry()) != null) {
                if (!entry.isDirectory()) {
                    map.put(entry.getName(), readAll(zin));
                }
                zin.closeEntry();
            }
        }
        return map;
    }

    private static void writeZip(Map<String, byte[]> entries, File output) throws IOException {
        try (ZipOutputStream zout = new ZipOutputStream(new FileOutputStream(output))) {
            zout.setLevel(java.util.zip.Deflater.DEFAULT_COMPRESSION);
            for (Map.Entry<String, byte[]> e : entries.entrySet()) {
                ZipEntry ze = new ZipEntry(e.getKey());
                zout.putNextEntry(ze);
                zout.write(e.getValue());
                zout.closeEntry();
            }
        }
    }

    private static byte[] readAsset(Context ctx, String path) {
        try (InputStream in = ctx.getAssets().open(path)) {
            return readAll(in);
        } catch (IOException e) {
            Log.w(TAG, "Asset not found: " + path);
            return null;
        }
    }

    private static byte[] readPayloadSo(Context ctx) {
        byte[] fromAsset = readAsset(ctx, "lib/arm64-v8a/" + PAYLOAD_LIB);
        if (fromAsset != null) return fromAsset;

        String nativeLibDir = ctx.getApplicationInfo().nativeLibraryDir;
        File soFile = new File(nativeLibDir, PAYLOAD_LIB);
        if (soFile.exists()) {
            try (FileInputStream fis = new FileInputStream(soFile)) {
                return readAll(fis);
            } catch (IOException e) {
                Log.e(TAG, "Cannot read payload SO: " + e.getMessage());
            }
        }
        return null;
    }

    private static byte[] readAll(InputStream in) throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        byte[] buf = new byte[8192];
        int len;
        while ((len = in.read(buf)) != -1) baos.write(buf, 0, len);
        return baos.toByteArray();
    }
}
