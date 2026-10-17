package com.venom.executor;

import android.content.Context;
import android.content.res.AssetManager;
import android.util.Log;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

public class LuaEngine {
    private static final String TAG = "VenomLuaEngine";

    static {
        System.loadLibrary("venom");
    }

    // Native methods
    public static native void   init();
    public static native String execute(String code);
    public static native String injectIntoGame(String libPath);
    public static native String getTargetPid();
    public static native void    resetState();
    public static native boolean isRootAvailable();

    /**
     * APK assets'inden bir dosyayı hedef konuma çıkarır.
     * @param context  Activity context
     * @param assetPath  assets içindeki yol (ör: "scripts/custom-4.lua")
     * @param destPath   Hedef dosya yolu (ör: "/data/local/tmp/custom-4.lua")
     * @return true başarılı, false hata
     */
    public static boolean extractAsset(Context context, String assetPath, String destPath) {
        AssetManager am = context.getAssets();
        File dest = new File(destPath);

        // Hedef dizini oluştur
        File parent = dest.getParentFile();
        if (parent != null && !parent.exists()) {
            parent.mkdirs();
        }

        try (InputStream in = am.open(assetPath);
             OutputStream out = new FileOutputStream(dest)) {
            byte[] buf = new byte[8192];
            int len;
            long total = 0;
            while ((len = in.read(buf)) != -1) {
                out.write(buf, 0, len);
                total += len;
            }
            Log.d(TAG, "Extracted " + assetPath + " → " + destPath + " (" + total + " bytes)");
            return true;
        } catch (IOException e) {
            Log.e(TAG, "extractAsset failed: " + e.getMessage());
            return false;
        }
    }

    /**
     * Script'in hedef konumda mevcut olup olmadığını kontrol eder.
     */
    public static boolean scriptExists(String path) {
        return new File(path).exists();
    }
}
