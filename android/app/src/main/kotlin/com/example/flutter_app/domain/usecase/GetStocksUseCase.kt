package com.example.flutter_app.domain.usecase

import com.example.flutter_app.data.model.StockResult
import com.example.flutter_app.domain.repository.StocksRepository
import javax.inject.Inject

class GetStocksUseCase @Inject constructor(private val repository: StocksRepository) {
    suspend operator fun invoke(ticker: String): StockResult {
        return repository.getStocks(ticker)
    }
}