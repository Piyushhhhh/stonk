package com.example.flutter_app.data.model

import io.flutter.plugins.Pigeon

sealed class StockInvestResult {
    data class Success(val data: List<Pigeon.StockInvest>) : StockInvestResult()
    data class Failure(val message: String, val error: Throwable) : StockInvestResult()
}