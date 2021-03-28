package com.makediff.library.domain.repository

import com.makediff.library.domain.entity.PostCate
import com.makediff.library.domain.entity.toDomain
import dev.icerock.moko.network.generated.apis.PostApi

class PostRepository internal constructor(
    private val postApi: PostApi
) {
    suspend fun getAllPostCategory(): List<PostCate> {
        return postApi.postCategoryList().map { it.toDomain() }
    }
}