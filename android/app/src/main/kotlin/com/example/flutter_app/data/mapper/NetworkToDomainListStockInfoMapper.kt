package com.example.flutter_app.data.mapper

import com.example.flutter_app.domain.model.TimeSeriesData
import dagger.assisted.Assisted
import dagger.assisted.AssistedFactory
import dagger.assisted.AssistedInject
import io.flutter.plugins.Pigeon


class NetworkToDomainListStockInfoMapper @AssistedInject constructor(
    private val networkToDomainStockInfoMapper: NetworkToDomainStockInfoMapper,
    @Assisted private val symbol: String
) {
    fun map(origin: Map<String, List<TimeSeriesData>>): List<Pigeon.Stock> {
        return origin.flatMap { (_, value) ->
            value.map { networkToDomainStockInfoMapper.map(it, symbol) }
        }
    }

    @AssistedFactory
    interface Factory {
        fun create(symbol: String): NetworkToDomainListStockInfoMapper
    }
}
