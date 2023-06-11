package com.example.flutter_app.data.datasource.api

import com.example.flutter_app.domain.model.StockInfos
import retrofit2.Response
import retrofit2.http.GET
import retrofit2.http.Query

interface StocksService {

    @GET("query")
    suspend fun getStockData(
        @Query("function") function: String = "GLOBAL_QUOTE",
        @Query("symbol") symbol: String,
        @Query("apikey") apiKey: String
    ): Response<StockInfos>
}
