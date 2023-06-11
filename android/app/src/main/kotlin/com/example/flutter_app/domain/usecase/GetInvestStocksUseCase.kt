package com.example.flutter_app.domain.usecase

import com.example.flutter_app.data.model.StockInvestResult
import com.example.flutter_app.domain.repository.StocksInvestRepository
import javax.inject.Inject

class GetInvestStocksUseCase @Inject constructor(private val repository: StocksInvestRepository) {
    suspend operator fun invoke(): StockInvestResult {
        return repository.getStocksInvest()
    }
}