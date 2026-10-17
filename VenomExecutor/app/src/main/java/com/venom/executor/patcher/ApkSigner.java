package com.venom.executor.patcher;

import android.util.Log;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.KeyStore;
import java.security.MessageDigest;
import java.security.PrivateKey;
import java.security.Signature;
import java.security.cert.X509Certificate;
import java.util.Base64;
import java.util.Enumeration;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.jar.Attributes;
import java.util.jar.JarEntry;
import java.util.jar.JarInputStream;
import java.util.jar.JarOutputStream;
import java.util.jar.Manifest;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;

public class ApkSigner {

    private static final String TAG = "ApkSigner";

    private final PrivateKey privateKey;
    private final X509Certificate certificate;

    public ApkSigner(PrivateKey key, X509Certificate cert) {
        this.privateKey  = key;
        this.certificate = cert;
    }

    public static ApkSigner fromTestKey() throws Exception {
        InputStream ks = ApkSigner.class.getResourceAsStream("/assets/testkey.p12");
        if (ks != null) {
            KeyStore store = KeyStore.getInstance("PKCS12");
            store.load(ks, "android".toCharArray());
            Enumeration<String> aliases = store.aliases();
            if (aliases.hasMoreElements()) {
                String alias = aliases.nextElement();
                PrivateKey key  = (PrivateKey)  store.getKey(alias, "android".toCharArray());
                X509Certificate cert = (X509Certificate) store.getCertificate(alias);
                return new ApkSigner(key, cert);
            }
        }
        return fromGeneratedKey();
    }

    public static ApkSigner fromGeneratedKey() throws Exception {
        KeyPairGenerator kpg = KeyPairGenerator.getInstance("RSA");
        kpg.initialize(2048);
        KeyPair kp = kpg.generateKeyPair();

        org.bouncycastle.x509.X509V3CertificateGenerator gen =
            new org.bouncycastle.x509.X509V3CertificateGenerator();

        org.bouncycastle.asn1.x500.X500Name subject =
            new org.bouncycastle.asn1.x500.X500Name("CN=VenomExecutor, O=NX Team, C=TR");

        gen.setSerialNumber(java.math.BigInteger.ONE);
        gen.setIssuerDN(new org.bouncycastle.jce.X509Principal("CN=VenomExecutor"));
        gen.setSubjectDN(new org.bouncycastle.jce.X509Principal("CN=VenomExecutor"));
        gen.setNotBefore(new java.util.Date(System.currentTimeMillis() - 86400000L));
        gen.setNotAfter(new java.util.Date(System.currentTimeMillis() + 86400000L * 365 * 30L));
        gen.setPublicKey(kp.getPublic());
        gen.setSignatureAlgorithm("SHA256WithRSAEncryption");

        X509Certificate cert = gen.generate(kp.getPrivate(), "BC");
        return new ApkSigner(kp.getPrivate(), cert);
    }

    public void signApk(File input, File output) throws Exception {
        Map<String, byte[]> entries = new LinkedHashMap<>();

        try (ZipInputStream zin = new ZipInputStream(new FileInputStream(input))) {
            ZipEntry entry;
            while ((entry = zin.getNextEntry()) != null) {
                String name = entry.getName();
                if (name.startsWith("META-INF/")) continue;
                byte[] data = readAll(zin);
                entries.put(name, data);
                zin.closeEntry();
            }
        }

        Manifest manifest = buildManifest(entries);
        byte[] manifestBytes = manifestToBytes(manifest);
        byte[] sfBytes       = buildSignatureFile(manifest, certificate);
        byte[] sigBlock      = signData(sfBytes);

        try (ZipOutputStream zout = new ZipOutputStream(java.nio.file.Files.newOutputStream(output.toPath()))) {
            for (Map.Entry<String, byte[]> e : entries.entrySet()) {
                ZipEntry ze = new ZipEntry(e.getKey());
                zout.putNextEntry(ze);
                zout.write(e.getValue());
                zout.closeEntry();
            }
            writeEntry(zout, "META-INF/MANIFEST.MF", manifestBytes);
            writeEntry(zout, "META-INF/CERT.SF",     sfBytes);
            writeEntry(zout, "META-INF/CERT.RSA",    sigBlock);
        }
        Log.d(TAG, "APK signed: " + output.getAbsolutePath());
    }

    private Manifest buildManifest(Map<String, byte[]> entries) throws Exception {
        Manifest mf = new Manifest();
        mf.getMainAttributes().put(Attributes.Name.MANIFEST_VERSION, "1.0");
        mf.getMainAttributes().put(new Attributes.Name("Created-By"), "VenomExecutor");

        MessageDigest sha256 = MessageDigest.getInstance("SHA-256");
        for (Map.Entry<String, byte[]> e : entries.entrySet()) {
            Attributes attr = new Attributes();
            byte[] digest = sha256.digest(e.getValue());
            attr.put(new Attributes.Name("SHA-256-Digest"), Base64.getEncoder().encodeToString(digest));
            mf.getEntries().put(e.getKey(), attr);
            sha256.reset();
        }
        return mf;
    }

    private byte[] manifestToBytes(Manifest mf) throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        mf.write(baos);
        return baos.toByteArray();
    }

    private byte[] buildSignatureFile(Manifest mf, X509Certificate cert) throws Exception {
        Manifest sf = new Manifest();
        sf.getMainAttributes().put(Attributes.Name.SIGNATURE_VERSION, "1.0");
        sf.getMainAttributes().put(new Attributes.Name("Created-By"), "VenomExecutor");
        sf.getMainAttributes().put(new Attributes.Name("X-Android-APK-Signed"), "2");

        byte[] mfBytes = manifestToBytes(mf);
        MessageDigest sha256 = MessageDigest.getInstance("SHA-256");
        byte[] mfDigest = sha256.digest(mfBytes);
        sf.getMainAttributes().put(new Attributes.Name("SHA-256-Digest-Manifest"),
            Base64.getEncoder().encodeToString(mfDigest));

        for (Map.Entry<String, Attributes> e : mf.getEntries().entrySet()) {
            ByteArrayOutputStream sectBaos = new ByteArrayOutputStream();
            sectBaos.write(("Name: " + e.getKey() + "\r\n").getBytes());
            for (Map.Entry<Object, Object> attr : e.getValue().entrySet()) {
                sectBaos.write((attr.getKey() + ": " + attr.getValue() + "\r\n").getBytes());
            }
            sectBaos.write("\r\n".getBytes());
            sha256.reset();
            byte[] digest = sha256.digest(sectBaos.toByteArray());
            Attributes sfAttr = new Attributes();
            sfAttr.put(new Attributes.Name("SHA-256-Digest"), Base64.getEncoder().encodeToString(digest));
            sf.getEntries().put(e.getKey(), sfAttr);
        }

        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        sf.write(baos);
        return baos.toByteArray();
    }

    private byte[] signData(byte[] data) throws Exception {
        Signature signer = Signature.getInstance("SHA256withRSA");
        signer.initSign(privateKey);
        signer.update(data);
        byte[] sig = signer.sign();

        org.bouncycastle.cms.CMSSignedDataGenerator gen = new org.bouncycastle.cms.CMSSignedDataGenerator();
        org.bouncycastle.cert.jcajce.JcaCertStore certStore =
            new org.bouncycastle.cert.jcajce.JcaCertStore(java.util.Arrays.asList(certificate));
        gen.addCertificates(certStore);

        org.bouncycastle.cms.jcajce.JcaSignerInfoGeneratorBuilder signerInfoBuilder =
            new org.bouncycastle.cms.jcajce.JcaSignerInfoGeneratorBuilder(
                new org.bouncycastle.operator.jcajce.JcaDigestCalculatorProviderBuilder().build());

        gen.addSignerInfoGenerator(signerInfoBuilder.build(
            new org.bouncycastle.operator.jcajce.JcaContentSignerBuilder("SHA256withRSA").build(privateKey),
            certificate));

        org.bouncycastle.cms.CMSProcessableByteArray content =
            new org.bouncycastle.cms.CMSProcessableByteArray(data);
        org.bouncycastle.cms.CMSSignedData cmsData = gen.generate(content, false);
        return cmsData.getEncoded();
    }

    private void writeEntry(ZipOutputStream zout, String name, byte[] data) throws IOException {
        ZipEntry entry = new ZipEntry(name);
        zout.putNextEntry(entry);
        zout.write(data);
        zout.closeEntry();
    }

    private byte[] readAll(InputStream in) throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        byte[] buf = new byte[8192];
        int len;
        while ((len = in.read(buf)) != -1) baos.write(buf, 0, len);
        return baos.toByteArray();
    }
}
