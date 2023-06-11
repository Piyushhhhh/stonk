package com.example.flutter_app.di

import com.example.flutter_app.data.datasource.api.StocksInvestService
import com.example.flutter_app.data.datasource.api.StocksService
import com.example.flutter_app.data.mapper.NetworkToDomainListStockInfoMapper
import com.example.flutter_app.data.mapper.NetworkToDomainListStockInvestMapper
import com.example.flutter_app.data.mapper.NetworkToDomainStockInfoMapper
import com.example.flutter_app.data.mapper.NetworkToDomainStockInvestMapper
import com.example.flutter_app.data.repository.StocksInvestRepositoryImpl
import com.example.flutter_app.data.repository.StocksRepositoryImpl
import com.example.flutter_app.domain.repository.StocksInvestRepository
import com.example.flutter_app.domain.repository.StocksRepository
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.components.ActivityRetainedComponent

@InstallIn(ActivityRetainedComponent::class)
@Module
object RepositoryModule {

    @Provides
    fun provideNetworkToDomainStockInfoMapper(): NetworkToDomainStockInfoMapper {
        return NetworkToDomainStockInfoMapper()
    }

    @Provides
    fun provideRepository(
        stocksService: StocksService,
        mapper: NetworkToDomainListStockInfoMapper.Factory
    ): StocksRepository {
        return StocksRepositoryImpl(stocksService, mapper)
    }

    // Invested stocks API dependencies
    @Provides
    fun provideNetworkToDomainStockInvestMapper(): NetworkToDomainStockInvestMapper {
        return NetworkToDomainStockInvestMapper()
    }

    @Provides
    fun provideInvestRepository(
        stocksService: StocksInvestService,
        mapper: NetworkToDomainListStockInvestMapper
    ): StocksInvestRepository {
        return StocksInvestRepositoryImpl(stocksService, mapper)
    }
}
