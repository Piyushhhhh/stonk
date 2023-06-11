package com.example.flutter_app.data.mapper

import com.example.flutter_app.domain.model.InvestStock
import io.flutter.plugins.Pigeon

class NetworkToDomainStockInvestMapper {
    fun map(origin: InvestStock): Pigeon.StockInvest {
        val stock = Pigeon.StockInvest()
        with(origin) {
            stock.symbol = symbol
            stock.name = companyName
            stock.investedTotal = quantity * avgPrice
            stock.quantity = quantity
            stock.currentValue = quantity * ltp
            stock.pl = quantity * ltp - quantity * avgPrice
            stock.percentagePL =
                (quantity * ltp) - (quantity * avgPrice) / (quantity * avgPrice) * 100
            stock.averagePrice = avgPrice
            stock.ltp = ltp
        }
        return stock
    }
}


