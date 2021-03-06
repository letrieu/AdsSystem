/*
 * Copyright 2019 IceRock MAG Inc. Use of this source code is governed by the Apache 2.0 license.
 */

package com.makediff.library

import com.github.aakira.napier.Antilog
import com.github.aakira.napier.Napier
import com.russhwolf.settings.Settings
import dev.icerock.moko.resources.StringResource
import dev.icerock.moko.resources.desc.ResourceFormatted
import dev.icerock.moko.resources.desc.StringDesc
import dev.icerock.moko.resources.desc.desc
import dev.icerock.moko.units.TableUnitItem
import com.makediff.library.domain.di.DomainFactory
import com.makediff.library.domain.entity.PostCate
import com.makediff.library.feature.config.di.ConfigFactory
import com.makediff.library.feature.config.model.ConfigStore
import com.makediff.library.feature.config.presentation.ConfigViewModel
import com.makediff.library.feature.list.di.ListFactory
import com.makediff.library.feature.list.model.ListSource
import com.makediff.library.feature.list.presentation.ListViewModel
import dev.icerock.moko.units.CollectionUnitItem

class SharedFactory(
    settings: Settings,
    antilog: Antilog,
    baseUrl: String,
    postCategoryUnitsFactory: PostCategoryUnitsFactory? = null
//    newsUnitsFactory: NewsUnitsFactory
) {
    private val domainFactory = DomainFactory(
        settings = settings,
        baseUrl = baseUrl
    )

    val postFactory: ListFactory<PostCate> = ListFactory(
        listSource = object : ListSource<PostCate> {
            override suspend fun getList(): List<PostCate> {
                return domainFactory.postRepository.getAllPostCategory()
            }
        },
        strings = object : ListViewModel.Strings {
            override val unknownError: StringResource = MR.strings.unknown_error
        },
        unitsFactory = object : ListViewModel.UnitsFactory<PostCate> {
            override fun createTile(data: PostCate): CollectionUnitItem {
                return postCategoryUnitsFactory?.createCateTile(
                        id = data.id ?: 0,
                        title = data.name.orEmpty(),
                        iconUrl = data.iconUrl.orEmpty()
                )!!
            }
        }
    )

//    val newsFactory: ListFactory<News> = ListFactory(
//        listSource = object : ListSource<News> {
//            override suspend fun getList(): List<News> {
//                return domainFactory.newsRepository.getNewsList()
//            }
//        },
//        strings = object : ListViewModel.Strings {
//            override val unknownError: StringResource = MR.strings.unknown_error
//        },
//        unitsFactory = object : ListViewModel.UnitsFactory<News> {
//            override fun createTile(data: News): TableUnitItem {
//                return newsUnitsFactory.createNewsTile(
//                    id = data.id.toLong(),
//                    title = data.fullName.orEmpty(),
//                    description = data.description?.desc() ?: MR.strings.no_description.desc()
//                )
//            }
//        }
//    )

    val configFactory = ConfigFactory(
        configStore = object : ConfigStore {
            override var apiToken: String?
                get() = domainFactory.configRepository.apiToken
                set(value) {
                    domainFactory.configRepository.apiToken = value
                }
            override var language: String?
                get() = domainFactory.configRepository.language
                set(value) {
                    domainFactory.configRepository.language = value
                }
        },
        validations = object : ConfigViewModel.Validations {
            override fun validateToken(value: String): StringDesc? {
                return if (value.isBlank()) {
                    MR.strings.invalid_token.desc()
                } else {
                    null
                }
            }

            override fun validateLanguage(value: String): StringDesc? {
                val validValues = listOf("ru", "us")
                return if (validValues.contains(value)) {
                    null
                } else {
                    StringDesc.ResourceFormatted(
                        MR.strings.invalid_language_s,
                        validValues.joinToString(", ")
                    )
                }
            }
        },
        defaultToken = "ed155d0a445e4b4fbd878fe1f3bc1b7f",
        defaultLanguage = "us"
    )

    init {
        Napier.base(antilog)
    }

    interface PostCategoryUnitsFactory {
        fun createCateTile(
            id: Long,
            title: String,
            iconUrl: String
        ): CollectionUnitItem
    }

//    interface NewsUnitsFactory {
//        fun createNewsTile(
//            id: Long,
//            title: String,
//            description: StringDesc
//        ): TableUnitItem
//    }
}
