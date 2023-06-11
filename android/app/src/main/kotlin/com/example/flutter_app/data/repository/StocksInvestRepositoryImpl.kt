package com.example.flutter_app.data.repository

import com.example.flutter_app.data.datasource.api.StocksInvestService
import com.example.flutter_app.data.mapper.NetworkToDomainListStockInvestMapper
import com.example.flutter_app.data.model.StockInvestResult
import com.example.flutter_app.domain.model.InvestedStocks
import com.example.flutter_app.domain.repository.StocksInvestRepository
import retrofit2.Response
import javax.inject.Inject

class StocksInvestRepositoryImpl @Inject constructor(
    private val stocksInvestService: StocksInvestService,
    private val mapper: NetworkToDomainListStockInvestMapper
) : StocksInvestRepository {
    override suspend fun getStocksInvest(): StockInvestResult {
        return try {
            val response = stocksInvestService.getInvestedStocks()
            if (response.isSuccessful) {
                response.body()?.let {
                    StockInvestResult.Success(mapper.map(it.stocks))
                } ?: buildFailureObject(response)
            } else {
                buildFailureObject(response)
            }
        } catch (exception: Exception) {
            StockInvestResult.Failure(
                "Failed to retrieve invest stock data: ${exception.message}",
                exception
            )
        }
    }

    private fun buildFailureObject(response: Response<InvestedStocks>) =
        StockInvestResult.Failure(
            "Failed to retrieve invest stock data",
            Throwable(response.body()?.toString())
        )
}