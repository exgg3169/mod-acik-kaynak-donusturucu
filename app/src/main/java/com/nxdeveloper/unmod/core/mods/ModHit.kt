package com.nxdeveloper.unmod.core.mods

/** A single search result row (a mod project, not a specific file/version). */
data class ModHit(
    val provider: ModProvider,
    val id: String,
    val name: String,
    val author: String,
    val description: String,
    val iconUrl: String?,
    val downloads: Long,
)
