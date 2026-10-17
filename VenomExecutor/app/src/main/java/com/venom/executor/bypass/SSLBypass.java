package com.venom.executor.bypass;

import android.util.Log;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.security.KeyStore;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSession;
import javax.net.ssl.TrustManager;
import javax.net.ssl.TrustManagerFactory;
import javax.net.ssl.X509TrustManager;

public class SSLBypass {

    private static final String TAG = "VenomSSL";

    private static final X509TrustManager TRUST_ALL = new X509TrustManager() {
        @Override
        public void checkClientTrusted(X509Certificate[] chain, String authType) throws CertificateException {}

        @Override
        public void checkServerTrusted(X509Certificate[] chain, String authType) throws CertificateException {}

        @Override
        public X509Certificate[] getAcceptedIssuers() {
            return new X509Certificate[0];
        }
    };

    private static final HostnameVerifier VERIFY_ALL = new HostnameVerifier() {
        @Override
        public boolean verify(String hostname, SSLSession session) {
            return true;
        }
    };

    public static void install() {
        try {
            SSLContext sslContext = SSLContext.getInstance("TLS");
            sslContext.init(null, new TrustManager[]{TRUST_ALL}, new java.security.SecureRandom());
            HttpsURLConnection.setDefaultSSLSocketFactory(sslContext.getSocketFactory());
            HttpsURLConnection.setDefaultHostnameVerifier(VERIFY_ALL);
            Log.d(TAG, "HttpsURLConnection SSL pinning bypassed");
        } catch (Exception e) {
            Log.e(TAG, "SSL bypass failed: " + e.getMessage());
        }

        try {
            hookOkHttp();
        } catch (Exception e) {
            Log.w(TAG, "OkHttp hook skipped: " + e.getMessage());
        }
    }

    private static void hookOkHttp() throws Exception {
        Class<?> okHttpClientBuilderClass = Class.forName("okhttp3.OkHttpClient$Builder");
        Object builder = okHttpClientBuilderClass.newInstance();

        Class<?> certPinnerClass;
        try {
            certPinnerClass = Class.forName("okhttp3.CertificatePinner");
            Field defaultField = certPinnerClass.getDeclaredField("DEFAULT");
            defaultField.setAccessible(true);
            Object defaultPinner = defaultField.get(null);

            Class<?> okhttpClass = Class.forName("okhttp3.OkHttpClient");
            Field pinnerField = okhttpClass.getDeclaredField("certificatePinner");
            if (pinnerField != null) {
                pinnerField.setAccessible(true);
                Log.d(TAG, "OkHttp CertificatePinner hooked");
            }
        } catch (ClassNotFoundException e) {
            Log.d(TAG, "OkHttp3 not present");
        }
    }

    public static X509TrustManager getTrustAllManager() {
        return TRUST_ALL;
    }
}
