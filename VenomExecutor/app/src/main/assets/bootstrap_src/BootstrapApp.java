package com.venom.loader;

import android.app.Application;
import android.content.Context;
import android.util.Log;

public class BootstrapApp extends Application {

    private static final String TAG = "VenomBootstrap";

    static {
        try {
            System.loadLibrary("venom_payload");
            Log.d(TAG, "libvenom_payload.so loaded");
        } catch (Throwable t) {
            Log.e(TAG, "Load failed: " + t.getMessage());
        }
    }

    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(base);
    }

    @Override
    public void onCreate() {
        super.onCreate();
        Log.d(TAG, "BootstrapApp started in " + getPackageName());
    }
}
