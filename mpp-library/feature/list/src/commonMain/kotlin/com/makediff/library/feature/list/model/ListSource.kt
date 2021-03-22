/*
 * Copyright 2019 IceRock MAG Inc. Use of this source code is governed by the Apache 2.0 license.
 */

package com.makediff.library.feature.list.model

interface ListSource<T> {
    suspend fun getList(): List<T>
}
