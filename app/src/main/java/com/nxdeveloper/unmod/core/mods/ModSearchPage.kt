package com.nxdeveloper.unmod.core.mods

/** One page of search results, with the provider's reported total count for pagination. */
data class ModSearchPage(
    val hits: List<ModHit>,
    val totalCount: Int,
)
