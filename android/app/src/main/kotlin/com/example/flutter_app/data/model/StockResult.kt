package com.example.flutter_app.data.model

import io.flutter.plugins.Pigeon

sealed class StockResult {
    data class Success(val data: List<Pigeon.Stock>) : StockResult()
    data class Failure(val message: String, val error: Throwable) : StockResult()
}