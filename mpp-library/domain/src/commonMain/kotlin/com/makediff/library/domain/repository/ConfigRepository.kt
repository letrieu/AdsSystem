/*
 * Copyright 2019 IceRock MAG Inc. Use of this source code is governed by the Apache 2.0 license.
 */

package com.makediff.library.domain.repository

import com.makediff.library.domain.storage.KeyValueStorage

class ConfigRepository(
    private val keyValueStorage: KeyValueStorage
) {
    var apiToken: String?
        get() = keyValueStorage.token
        set(value) {
            keyValueStorage.token = value
        }

    var language: String?
        get() = keyValueStorage.language
        set(value) {
            keyValueStorage.language = value
        }
}
