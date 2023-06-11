package com.example.flutter_app.presentation.utils

data class Resource<out T>(
    val status: Status,
    val data: T?,
    val error: Throwable?,
    val message: String?
) {

    companion object {

        fun <T> success(data: T?): Resource<T> {
            return Resource(Status.SUCCESS, data, null, null)
        }

        fun <T> error(msg: String, error: Throwable?): Resource<T> {
            return Resource(Status.ERROR, null, error, msg)
        }

        fun <T> loading(data: T?): Resource<T> {
            return Resource(Status.LOADING, data, null, null)
        }

    }

}