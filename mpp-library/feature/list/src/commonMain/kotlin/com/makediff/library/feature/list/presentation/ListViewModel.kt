/*
 * Copyright 2019 IceRock MAG Inc. Use of this source code is governed by the Apache 2.0 license.
 */

package com.makediff.library.feature.list.presentation

import com.github.aakira.napier.Napier
import dev.icerock.moko.mvvm.State
import dev.icerock.moko.mvvm.livedata.LiveData
import dev.icerock.moko.mvvm.livedata.MutableLiveData
import dev.icerock.moko.mvvm.livedata.dataTransform
import dev.icerock.moko.mvvm.livedata.errorTransform
import dev.icerock.moko.mvvm.livedata.map
import dev.icerock.moko.mvvm.viewmodel.ViewModel
import dev.icerock.moko.resources.StringResource
import dev.icerock.moko.resources.desc.StringDesc
import dev.icerock.moko.resources.desc.desc
import kotlinx.coroutines.launch
import com.makediff.library.feature.list.model.ListSource
import dev.icerock.moko.mvvm.asState
import dev.icerock.moko.units.CollectionUnitItem

class ListViewModel<T>(
    private val listSource: ListSource<T>,
    private val strings: Strings,
    private val unitsFactory: UnitsFactory<T>
) : ViewModel() {

    private val _state: MutableLiveData<State<List<T>, Throwable>> =
        MutableLiveData(initialValue = State.Loading())

    val state: LiveData<State<List<CollectionUnitItem>, StringDesc>> = _state
        .dataTransform {
            map { news ->
                news.map { unitsFactory.createTile(it) }
            }
        }
        .errorTransform {
            // new type inferrence require set types oO
            map<Throwable, StringDesc> { it.message?.desc() ?: strings.unknownError.desc() }
        }

    init {
        loadList()
    }

    fun onRetryPressed() {
        loadList()
    }

    fun onRefresh(completion: () -> Unit) {
        viewModelScope.launch {
            @Suppress("TooGenericExceptionCaught") // ktor on ios fail with Throwable when no network
            try {
                val items = listSource.getList()

                _state.value = items.asState()
            } catch (error: Throwable) {
                Napier.e("can't refresh", throwable = error)
            } finally {
                completion()
            }
        }
    }

    private fun loadList() {
        viewModelScope.launch {
            @Suppress("TooGenericExceptionCaught") // ktor on ios fail with Throwable when no network
            try {
                _state.value = State.Loading()

                val items = listSource.getList()

                _state.value = items.asState()
            } catch (error: Throwable) {
                _state.value = State.Error(error)
            }
        }
    }

    interface UnitsFactory<T> {
        fun createTile(data: T): CollectionUnitItem
    }

    interface Strings {
        val unknownError: StringResource
    }
}
