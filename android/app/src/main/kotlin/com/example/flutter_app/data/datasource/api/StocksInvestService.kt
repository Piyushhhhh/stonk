package com.example.flutter_app.data.datasource.api

import com.example.flutter_app.domain.model.InvestedStocks
import retrofit2.Response
import retrofit2.http.GET

interface StocksInvestService {
    @GET("query")
    suspend fun getInvestedStocks(): Response<InvestedStocks>
}