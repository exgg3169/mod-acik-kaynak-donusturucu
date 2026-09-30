package com.nxdeveloper.unmod.core.mods

/** Mod loader kind, with the id each provider's API expects. */
enum class ModLoader(val label: String, val modrinth: String?, val curseforge: Int) {
    ANY("Any", null, 0),
    FABRIC("Fabric", "fabric", 4),
    FORGE("Forge", "forge", 1),
    NEOFORGE("NeoForge", "neoforge", 6),
    QUILT("Quilt", "quilt", 5),
}
