package com.example.flutter_app.data.repository

import com.example.flutter_app.data.datasource.api.StocksService
import com.example.flutter_app.data.mapper.NetworkToDomainListStockInfoMapper
import com.example.flutter_app.data.model.StockResult
import com.example.flutter_app.domain.model.StockInfos
import com.example.flutter_app.domain.repository.StocksRepository
import retrofit2.Response
import javax.inject.Inject

class StocksRepositoryImpl @Inject constructor(
    private val stocksService: StocksService,
    private val mapperFactory: NetworkToDomainListStockInfoMapper.Factory
) :
    StocksRepository {
    override suspend fun getStocks(
        ticker: String,
    ): StockResult {
        return try {
            val response = stocksService.getStockData(
                "TIME_SERIES_WEEKLY",
                ticker,
                "Q0PYSCYMTDG5JX5D"
            )
            if (response.isSuccessful && response.body() != null
                && response.body()?.timeSeries != null
                && !response.body()?.toString()?.contains("Error")!!
            ) {
                response.body()?.timeSeries?.let {
                    StockResult.Success(
                        mapperFactory.create(ticker).map(it.timeSeriesData)
                    )
                } ?: buildFailureObject(response)
            } else {
                buildFailureObject(response)
            }
        } catch (exception: Exception) {
            StockResult.Failure("Failed to retrieve stock data: ${exception.message}", exception)
        }

    }

    private fun buildFailureObject(response: Response<StockInfos>) =
        StockResult.Failure(
            "Failed to retrieve stock data",
            Throwable(response.body()?.toString())
        )

}