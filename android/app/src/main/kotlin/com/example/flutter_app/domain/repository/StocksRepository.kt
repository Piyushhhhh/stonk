package com.example.flutter_app.domain.repository

import com.example.flutter_app.data.model.StockResult

interface StocksRepository {
    suspend fun getStocks(ticker: String): StockResult
}
