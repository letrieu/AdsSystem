/*
 * Copyright 2019 IceRock MAG Inc. Use of this source code is governed by the Apache 2.0 license.
 */

package com.makediff.library.domain.di

import com.github.aakira.napier.Napier
import com.russhwolf.settings.Settings
import dev.icerock.moko.network.exceptionfactory.HttpExceptionFactory
import dev.icerock.moko.network.exceptionfactory.parser.ErrorExceptionParser
import dev.icerock.moko.network.exceptionfactory.parser.ValidationExceptionParser
import dev.icerock.moko.network.features.ExceptionFeature
import dev.icerock.moko.network.features.TokenFeature
import io.ktor.client.HttpClient
import io.ktor.client.features.logging.LogLevel
import io.ktor.client.features.logging.Logger
import io.ktor.client.features.logging.Logging
import io.ktor.http.HttpStatusCode
import kotlinx.serialization.json.Json
import com.makediff.library.domain.repository.ConfigRepository
import com.makediff.library.domain.repository.PostRepository
import com.makediff.library.domain.storage.KeyValueStorage
import dev.icerock.moko.network.generated.apis.PostApi
import dev.icerock.moko.network.generated.apis.ShopApi
import dev.icerock.moko.network.generated.apis.UserApi

class DomainFactory(
    private val settings: Settings,
    private val baseUrl: String
) {
    private val keyValueStorage: KeyValueStorage by lazy { KeyValueStorage(settings) }

    private val json: Json by lazy {
        Json {
            ignoreUnknownKeys = true
        }
    }

    private val httpClient: HttpClient by lazy {
        HttpClient {
            install(ExceptionFeature) {
                exceptionFactory = HttpExceptionFactory(
                    defaultParser = ErrorExceptionParser(json),
                    customParsers = mapOf(
                        HttpStatusCode.UnprocessableEntity.value to ValidationExceptionParser(json)
                    )
                )
            }
            install(Logging) {
                logger = object : Logger {
                    override fun log(message: String) {
                        Napier.d(message = message)
                    }
                }
                level = LogLevel.HEADERS
            }
            install(TokenFeature) {
                tokenHeaderName = "Authorization"
                tokenProvider = object : TokenFeature.TokenProvider {
                    override fun getToken(): String? = keyValueStorage.token
                }
            }

            // disable standard BadResponseStatus - exceptionfactory do it for us
            expectSuccess = false
        }
    }

    private val userApi: UserApi by lazy {
        UserApi(
            basePath = baseUrl,
            httpClient = httpClient,
            json = json
        )
    }

    private val postApi: PostApi by lazy {
        PostApi(
            basePath = baseUrl,
            httpClient = httpClient,
            json = json
        )
    }

    private val shopApi: ShopApi by lazy {
        ShopApi(
            basePath = baseUrl,
            httpClient = httpClient,
            json = json
        )
    }


    val postRepository: PostRepository by lazy {
        PostRepository(postApi = postApi)
    }
//
//    val newsRepository: NewsRepository by lazy {
//        NewsRepository(
//            newsApi = newsApi,
//            keyValueStorage = keyValueStorage
//        )
//    }

    val configRepository: ConfigRepository by lazy {
        ConfigRepository(keyValueStorage = keyValueStorage)
    }
}
