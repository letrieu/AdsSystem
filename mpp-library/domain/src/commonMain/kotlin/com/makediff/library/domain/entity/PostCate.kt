package com.makediff.library.domain.entity

import dev.icerock.moko.network.generated.models.PostCategory
import dev.icerock.moko.parcelize.Parcelable
import dev.icerock.moko.parcelize.Parcelize

@Parcelize
data class PostCate(
    val id: Long?,
    val name: String?,
    val iconUrl: String?
) : Parcelable

internal fun PostCategory.toDomain(): PostCate = PostCate(
    id = this.id,
    name = this.name,
    iconUrl = this.iconUrl
)