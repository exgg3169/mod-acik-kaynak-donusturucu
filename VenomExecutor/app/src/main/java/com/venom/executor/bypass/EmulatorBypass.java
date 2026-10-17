package com.venom.executor.bypass;

import android.os.Build;
import android.util.Log;

import java.lang.reflect.Field;

public class EmulatorBypass {

    private static final String TAG = "VenomEmu";

    public static void spoof() {
        try {
            setFinalField(Build.class, "FINGERPRINT",
                "samsung/dreamltexx/dreamlte:9/PPR1.180610.011/G950FXXS5DSI1:user/release-keys");
            setFinalField(Build.class, "MODEL", "SM-G950F");
            setFinalField(Build.class, "MANUFACTURER", "samsung");
            setFinalField(Build.class, "BRAND", "samsung");
            setFinalField(Build.class, "DEVICE", "dreamlte");
            setFinalField(Build.class, "PRODUCT", "dreamltexx");
            setFinalField(Build.class, "HARDWARE", "samsungexynos8895");
            setFinalField(Build.class, "TAGS", "release-keys");
            setFinalField(Build.class, "TYPE", "user");
            setFinalField(Build.class, "HOST", "SWDD6833");
            setFinalField(Build.class, "USER", "dpi");

            Log.d(TAG, "Build fields spoofed to Samsung Galaxy S8");
        } catch (Exception e) {
            Log.e(TAG, "Emulator bypass failed: " + e.getMessage());
        }
    }

    private static void setFinalField(Class<?> clazz, String fieldName, Object value) {
        try {
            Field field = clazz.getDeclaredField(fieldName);
            field.setAccessible(true);

            try {
                Field modifiersField = Field.class.getDeclaredField("accessFlags");
                modifiersField.setAccessible(true);
                int flags = modifiersField.getInt(field);
                modifiersField.setInt(field, flags & ~0x10);
            } catch (Exception ignored) {
            }

            field.set(null, value);
        } catch (Exception e) {
            Log.w(TAG, "Could not set " + fieldName + ": " + e.getMessage());
        }
    }
}
