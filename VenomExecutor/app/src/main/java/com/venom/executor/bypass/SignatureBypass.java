package com.venom.executor.bypass;

import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.Signature;
import android.util.Log;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;

public class SignatureBypass {

    private static final String TAG = "VenomSigBypass";

    private static final byte[] FAKE_SIG = new byte[]{
        0x30, (byte)0x82, 0x01, (byte)0x8D, 0x30, (byte)0x82, 0x01, 0x32,
        (byte)0xA0, 0x03, 0x02, 0x01, 0x02, 0x02, 0x04, 0x5F,
        (byte)0xBA, 0x2E, (byte)0x96, 0x30, 0x0D, 0x06, 0x09, 0x2A,
    };

    public static void install(Context ctx) {
        try {
            hookPackageManager(ctx);
            Log.d(TAG, "SignatureBypass installed");
        } catch (Exception e) {
            Log.e(TAG, "SignatureBypass failed: " + e.getMessage());
        }
    }

    private static void hookPackageManager(Context ctx) throws Exception {
        PackageManager original = ctx.getPackageManager();

        Object activityThread = getActivityThread();
        Field pmField = activityThread.getClass().getDeclaredField("sPackageManager");
        pmField.setAccessible(true);
        Object ipm = pmField.get(activityThread);

        if (ipm == null) return;

        Class<?> ipmClass = ipm.getClass().getInterfaces()[0];
        if (ipmClass == null) {
            for (Class<?> iface : ipm.getClass().getInterfaces()) {
                if (iface.getName().contains("IPackageManager")) {
                    ipmClass = iface;
                    break;
                }
            }
        }

        if (ipmClass == null) {
            Log.w(TAG, "IPackageManager interface not found, skipping deep hook");
            return;
        }

        final Object finalIpm = ipm;
        final Class<?> finalIpmClass = ipmClass;

        Object proxy = Proxy.newProxyInstance(
            ipm.getClass().getClassLoader(),
            new Class<?>[]{finalIpmClass},
            new InvocationHandler() {
                @Override
                public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
                    String name = method.getName();
                    if ("getPackageInfo".equals(name) || "generatePackageInfo".equals(name)) {
                        if (args != null) {
                            for (Object arg : args) {
                                if (arg instanceof String) {
                                    String pkg = (String) arg;
                                    if (pkg.contains("blockymods") || pkg.contains("sandboxol")) {
                                        try {
                                            Object result = method.invoke(finalIpm, args);
                                            if (result instanceof PackageInfo) {
                                                PackageInfo pi = (PackageInfo) result;
                                                if (pi.signatures != null && pi.signatures.length > 0) {
                                                    Log.d(TAG, "Signature intercept for: " + pkg);
                                                    return result;
                                                }
                                            }
                                            return result;
                                        } catch (Exception e) {
                                            return method.invoke(finalIpm, args);
                                        }
                                    }
                                }
                            }
                        }
                    }
                    return method.invoke(finalIpm, args);
                }
            }
        );

        pmField.set(activityThread, proxy);
        Log.d(TAG, "PackageManager hooked");
    }

    private static Object getActivityThread() throws Exception {
        Class<?> atClass = Class.forName("android.app.ActivityThread");
        Method currentAtMethod = atClass.getDeclaredMethod("currentActivityThread");
        currentAtMethod.setAccessible(true);
        return currentAtMethod.invoke(null);
    }

    public static Signature[] getFakeSignatures() {
        return new Signature[]{new Signature(FAKE_SIG)};
    }
}
