package com.makediff.library.domain.repository

import dev.icerock.moko.network.generated.apis.ShopApi
import dev.icerock.moko.network.generated.models.ShopListType

class ShopRepository internal constructor(
    private val shopApi: ShopApi
) {
//    suspend fun getNewsList(query: String? = null, page: Int = 1, pageSize: Int = 20): List<News> {
//        return newsApi.topHeadlinesGet(
//            country = keyValueStorage.language,
//            category = null,
//            q = query,
//            page = page,
//            pageSize = pageSize
//        ).articles.map { it.toDomain() }
//    }

//    suspend fun getShopCategoryList(): List<ShopListType> {
//        return shopApi.shopCategoryList()
//    }
}