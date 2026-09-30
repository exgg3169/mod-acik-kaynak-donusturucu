package com.nxdeveloper.unmod.ui

import androidx.compose.runtime.compositionLocalOf

/** Every user-visible piece of text in the app, in one place, per language. */
data class Strings(
    val languageCode: String,
    // Top bar / logo
    val tagline: String,
    val settingsIcon: String,
    // File picker
    val pickAJar: String,
    val noFileSelected: String,
    val chooseFile: String,
    val clear: String,
    val decompile: String,
    // Progress / result / error cards
    val cancel: String,
    val done: String,
    val totalClasses: String,
    val decompiledCount: String,
    val failedCount: String,
    val resources: String,
    val decompileAnother: String,
    val failed: String,
    val dismiss: String,
    // Settings
    val settingsTitle: String,
    val runInBackground: String,
    val providerInfo: String,
    val close: String,
    // Mod browser
    val browseModsOnline: String,
    val curseforgeNoSearchNotice: String,
    val searchModsLabel: String,
    val curseforgeLinkLabel: String,
    val mcVersionOptionalLabel: String,
    val search: String,
    val searching: String,
    val load: String,
    val loading: String,
    val by: String,
    val downloads: String,
    val noFilesForFilters: String,
    val pageOf: String,
    // Engine stage labels (shown while a decompile job runs)
    val stageDownloading: String,
    val stageLoading: String,
    val stageDecompiling: String,
    val stageZipping: String,
    val stageSaving: String,
    val stageDone: String,
    val stageFailed: String,
    val readingJar: String,
    val preparing: String,
    val packing: String,
    // Language picker (first launch)
    val chooseLanguageTitle: String,
    val chooseLanguageSubtitle: String,
) {
    fun stageLabel(stage: String): String = when (stage) {
        "Downloading" -> stageDownloading
        "Loading" -> stageLoading
        "Decompiling" -> stageDecompiling
        "Zipping" -> stageZipping
        "Saving" -> stageSaving
        "Done" -> stageDone
        "Failed" -> stageFailed
        else -> stage
    }
}

val EnglishStrings = Strings(
    languageCode = "en",
    tagline = "Minecraft Java Uninstaller",
    settingsIcon = "Settings",
    pickAJar = "Pick a mod JAR",
    noFileSelected = "No file selected",
    chooseFile = "Choose file",
    clear = "Clear",
    decompile = "Decompile",
    cancel = "Cancel",
    done = "Done",
    totalClasses = "Total classes",
    decompiledCount = "Decompiled",
    failedCount = "Failed",
    resources = "Resources",
    decompileAnother = "Decompile another",
    failed = "Failed",
    dismiss = "Dismiss",
    settingsTitle = "Settings",
    runInBackground = "Run in background",
    providerInfo = "Modrinth is searched directly, no key needed. For CurseForge, paste a mod's " +
        "curseforge.com page link in the browser below instead of searching — no API key " +
        "required either.",
    close = "Close",
    browseModsOnline = "Or browse mods online",
    curseforgeNoSearchNotice = "CurseForge has no free search — paste a mod's curseforge.com page " +
        "link below (e.g. curseforge.com/minecraft/mc-mods/jei) and its files will load directly.",
    searchModsLabel = "Search mods",
    curseforgeLinkLabel = "CurseForge mod page link",
    mcVersionOptionalLabel = "Minecraft version (optional)",
    search = "Search",
    searching = "Searching...",
    load = "Load",
    loading = "Loading...",
    by = "by",
    downloads = "downloads",
    noFilesForFilters = "No files found for this loader/version.",
    pageOf = "Page %1\$d / %2\$d",
    stageDownloading = "Downloading",
    stageLoading = "Loading",
    stageDecompiling = "Decompiling",
    stageZipping = "Zipping",
    stageSaving = "Saving",
    stageDone = "Done",
    stageFailed = "Failed",
    readingJar = "Reading JAR...",
    preparing = "Preparing...",
    packing = "Packing...",
    chooseLanguageTitle = "Choose your language",
    chooseLanguageSubtitle = "You can change this later in Settings.",
)

val TurkishStrings = Strings(
    languageCode = "tr",
    tagline = "Minecraft Java Kaldırıcı",
    settingsIcon = "Ayarlar",
    pickAJar = "Bir mod JAR dosyası seç",
    noFileSelected = "Dosya seçilmedi",
    chooseFile = "Dosya seç",
    clear = "Temizle",
    decompile = "Dönüştür",
    cancel = "İptal",
    done = "Tamamlandı",
    totalClasses = "Toplam sınıf",
    decompiledCount = "Dönüştürülen",
    failedCount = "Başarısız",
    resources = "Kaynaklar",
    decompileAnother = "Başka bir dosya dönüştür",
    failed = "Başarısız",
    dismiss = "Kapat",
    settingsTitle = "Ayarlar",
    runInBackground = "Arka planda çalıştır",
    providerInfo = "Modrinth doğrudan aranır, anahtar gerekmez. CurseForge için, arama yapmak " +
        "yerine aşağıdaki tarayıcıya bir modun curseforge.com sayfa linkini yapıştır — burada da " +
        "API anahtarı gerekmez.",
    close = "Kapat",
    browseModsOnline = "Veya çevrimiçi mod ara",
    curseforgeNoSearchNotice = "CurseForge'un ücretsiz araması yok — aşağıya bir modun " +
        "curseforge.com sayfa linkini yapıştır (örn. curseforge.com/minecraft/mc-mods/jei), " +
        "dosyaları doğrudan yüklenecek.",
    searchModsLabel = "Mod ara",
    curseforgeLinkLabel = "CurseForge mod sayfası linki",
    mcVersionOptionalLabel = "Minecraft sürümü (isteğe bağlı)",
    search = "Ara",
    searching = "Aranıyor...",
    load = "Yükle",
    loading = "Yükleniyor...",
    by = "yapan:",
    downloads = "indirme",
    noFilesForFilters = "Bu loader/sürüm için dosya bulunamadı.",
    pageOf = "Sayfa %1\$d / %2\$d",
    stageDownloading = "İndiriliyor",
    stageLoading = "Yükleniyor",
    stageDecompiling = "Dönüştürülüyor",
    stageZipping = "Sıkıştırılıyor",
    stageSaving = "Kaydediliyor",
    stageDone = "Tamamlandı",
    stageFailed = "Başarısız",
    readingJar = "JAR okunuyor...",
    preparing = "Hazırlanıyor...",
    packing = "Paketleniyor...",
    chooseLanguageTitle = "Dilini seç",
    chooseLanguageSubtitle = "Bunu daha sonra Ayarlar'dan değiştirebilirsin.",
)

val LocalStrings = compositionLocalOf { EnglishStrings }

fun stringsFor(languageCode: String?): Strings = when (languageCode) {
    "tr" -> TurkishStrings
    "en" -> EnglishStrings
    else -> EnglishStrings
}
