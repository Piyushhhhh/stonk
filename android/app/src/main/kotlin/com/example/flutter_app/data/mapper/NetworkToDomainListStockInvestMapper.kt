package com.example.flutter_app.data.mapper

import com.example.flutter_app.domain.model.InvestStock
import io.flutter.plugins.Pigeon
import javax.inject.Inject

class NetworkToDomainListStockInvestMapper @Inject constructor(
    private val networkToDomainStockInvestMapper: NetworkToDomainStockInvestMapper
) {
    fun map(origin: List<InvestStock>): List<Pigeon.StockInvest> {
        return origin.map { networkToDomainStockInvestMapper.map(it) }
    }
}
