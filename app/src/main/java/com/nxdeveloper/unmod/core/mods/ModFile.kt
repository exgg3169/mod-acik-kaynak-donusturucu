package com.nxdeveloper.unmod.core.mods

/** A single downloadable file belonging to a [ModHit] (a specific build/version of the mod). */
data class ModFile(
    val id: String,
    val displayName: String,
    val fileName: String,
    val downloadUrl: String?,
    val sizeBytes: Long,
    val gameVersions: List<String>,
    val loaders: List<String>,
)
