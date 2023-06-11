package com.example.flutter_app.data.mapper

import com.example.flutter_app.domain.model.TimeSeriesData
import io.flutter.plugins.Pigeon

class NetworkToDomainStockInfoMapper {
    fun map(origin: TimeSeriesData, symbol: String): Pigeon.Stock {
        val stock = Pigeon.Stock()
        with(origin) {
            stock.symbol = symbol
            stock.name = symbol
            stock.price = open.toDouble()
            stock.date = date
            stock.change = high.toDouble() - low.toDouble()
            stock.percentChange = (open.toDouble() / (high.toDouble() - low.toDouble())) * 100
        }
        return stock
    }
}

