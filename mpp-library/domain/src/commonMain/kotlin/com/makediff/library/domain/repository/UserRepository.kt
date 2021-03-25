package com.makediff.library.domain.repository

import dev.icerock.moko.network.generated.apis.UserApi

class UserRepository internal constructor(
    private val userApi: UserApi
) {
}