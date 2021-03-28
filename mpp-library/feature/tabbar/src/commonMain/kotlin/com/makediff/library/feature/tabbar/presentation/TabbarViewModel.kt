package com.makediff.library.feature.tabbar.presentation

import dev.icerock.moko.mvvm.dispatcher.EventsDispatcher
import dev.icerock.moko.mvvm.dispatcher.EventsDispatcherOwner
import dev.icerock.moko.mvvm.livedata.LiveData
import dev.icerock.moko.mvvm.livedata.MutableLiveData
import dev.icerock.moko.mvvm.viewmodel.ViewModel

class TabbarViewModel(
        override val eventsDispatcher: EventsDispatcher<EventsListener>
) : ViewModel(), EventsDispatcherOwner<TabbarViewModel.EventsListener> {
    private val _selectedTab: MutableLiveData<Int> = MutableLiveData(0)

    val selectedTab: LiveData<Int> = _selectedTab

    fun onBarButtonPressed(index: Int) {
        val current = _selectedTab.value

        if (index < 0 || index > 4) {
            //Invalid index
            return
        }

        _selectedTab.value = index

        if (selectedTab.value == 0) {
            eventsDispatcher.dispatchEvent { routeToHomeTab() }
        } else if (selectedTab.value == 1) {
            eventsDispatcher.dispatchEvent { routeToHotTab() }
        } else if (selectedTab.value == 2) {
            eventsDispatcher.dispatchEvent { routeToShopTab() }
        } else if (selectedTab.value == 3) {
            eventsDispatcher.dispatchEvent { routeToNearTab() }
        } else {
            eventsDispatcher.dispatchEvent { routeToNotificationTab() }
        }
    }

    interface EventsListener {
        fun routeToHomeTab()
        fun routeToHotTab()
        fun routeToShopTab()
        fun routeToNearTab()
        fun routeToNotificationTab()
    }
}