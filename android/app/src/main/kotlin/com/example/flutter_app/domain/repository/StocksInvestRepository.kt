package com.example.flutter_app.domain.repository

import com.example.flutter_app.data.model.StockInvestResult

interface StocksInvestRepository {
    suspend fun getStocksInvest(): StockInvestResult
}
