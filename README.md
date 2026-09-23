# Mod Açık Kaynak Dönüştürücü

Elinizdeki derlenmiş bir Minecraft: Java Edition mod dosyasını (`.jar`) telefonunuzdan
seçip, [Vineflower](https://vineflower.org/) decompiler motoruyla okunabilir Java
kaynak koduna dönüştüren, tamamen açık kaynak bir Android uygulaması.

Uygulama genel amaçlıdır: belirli bir moda bağlı değildir, herhangi bir `.jar`
(mod, kütüphane, plugin) dosyasını girdi olarak kabul eder.

## Nasıl çalışır?

1. **Mod Dosyası Seç** ile cihazınızdaki `.jar` dosyasını seçin (Storage Access
   Framework kullanılır, ekstra depolama izni istenmez).
2. **Açık Kaynağa Dönüştür** butonuna basın. Uygulama, dosyayı arka planda
   Vineflower ile decompile eder ve ilerlemeyi canlı günlükte gösterir.
3. İşlem bitince üretilen `.zip` arşivini (içinde `.java` kaynak dosyaları
   bulunur) **Paylaş** ile başka bir uygulamaya gönderebilir ya da **Kaydet**
   ile cihazınızda istediğiniz konuma yazabilirsiniz.

## Neden bu araç?

Kapalı kaynak dağıtılan bir mod'un iç yapısını incelemek, hata ayıklamak,
uyumluluk sorunlarını çözmek veya modun kendi lisansı izin veriyorsa katkıda
bulunmak isteyenler için pratik, masaüstü gerektirmeyen bir çözüm sağlar.

**Önemli:** Bu araç yalnızca bytecode'u okunabilir kaynak koda çevirir; hiçbir
üçüncü tarafın telif hakkını veya lisansını değiştirmez ya da devretmez.
Decompile ettiğiniz bir modun kaynağını dağıtma, değiştirme veya yeniden
yayınlama hakkına sahip olup olmadığınızı, o modun kendi lisansına göre siz
kontrol etmelisiniz.

## Kaynaktan derleme

```bash
./gradlew assembleDebug
# APK: app/build/outputs/apk/debug/app-debug.apk
```

Gereksinimler: JDK 17, Android SDK (compileSdk 34, build-tools 34.0.0).
`ANDROID_HOME` ortam değişkenini SDK klasörünüze ayarlamanız yeterli;
Gradle sürümü `gradlew` ile otomatik indirilir.

## Kullanılan bileşenler

- [Vineflower](https://github.com/Vineflower/vineflower) — MIT lisanslı,
  aktif geliştirilen Java decompiler (Fernflower'ın devamı).
- AndroidX / Material Components.

## Lisans

Bu proje [GNU AGPLv3](LICENSE) ile lisanslanmıştır. Kaynak kodunun tamamı bu
depoda yer alır; uygulamayı değiştirip bir servis olarak sunanların da
değişikliklerini AGPLv3 koşullarına göre paylaşması gerekir.
