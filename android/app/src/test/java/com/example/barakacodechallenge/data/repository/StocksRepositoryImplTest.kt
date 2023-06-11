package com.example.barakacodechallenge.data.repository

import com.example.flutter_app.data.datasource.api.StocksService
import com.example.flutter_app.data.mapper.NetworkToDomainListStockInfoMapper
import com.example.flutter_app.data.model.StockResult
import com.example.flutter_app.data.repository.StocksRepositoryImpl
import com.example.flutter_app.domain.model.StockInfos
import com.example.flutter_app.domain.model.TimeSeries
import com.example.flutter_app.domain.model.TimeSeriesData
import com.nhaarman.mockitokotlin2.whenever
import io.flutter.plugins.Pigeon
import kotlinx.coroutines.runBlocking
import org.junit.Assert.assertTrue
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.mockito.Mock
import org.mockito.junit.MockitoJUnitRunner
import retrofit2.Response

@RunWith(MockitoJUnitRunner::class)
class StocksRepositoryImplTest {

    @Mock
    private lateinit var responseNetworkStocks: Response<StockInfos>

    @Mock
    lateinit var stocksInfos: StockInfos

    @Mock
    lateinit var timeSeries: TimeSeries

    @Mock
    private lateinit var listStock: List<Pigeon.Stock>

    @Mock
    private lateinit var timeSeriesData: Map<String, List<TimeSeriesData>>

    @Mock
    private lateinit var stocksService: StocksService

    @Mock
    private lateinit var mapperFactory: NetworkToDomainListStockInfoMapper.Factory

    @Mock
    private lateinit var mapper: NetworkToDomainListStockInfoMapper

    private lateinit var sut: StocksRepositoryImpl

    @Before
    fun setUp() {
        sut = StocksRepositoryImpl(stocksService, mapperFactory)
    }

    @Test
    fun `getStocks with correct parameters should return success`() {
        runBlocking {
            whenever(responseNetworkStocks.isSuccessful).thenReturn(true)
            whenever(responseNetworkStocks.body()).thenReturn(stocksInfos)
            whenever(responseNetworkStocks.body()?.timeSeries).thenReturn(timeSeries)
            whenever(
                stocksService.getStockData(
                    "TIME_SERIES_WEEKLY",
                    "NFLX",
                    "Q0PYSCYMTDG5JX5D"
                )
            ).thenReturn(responseNetworkStocks)
            whenever(
                stocksService.getStockData(
                    "TIME_SERIES_WEEKLY",
                    "NFLX",
                    "Q0PYSCYMTDG5JX5D"
                ).body()
            ).thenReturn(stocksInfos)
            whenever(mapperFactory.create("NFLX")).thenReturn(mapper)
            whenever(mapper.map(timeSeriesData)).thenReturn(listStock)

            val result = sut.getStocks("NFLX")
            assertTrue(result is StockResult.Success)
        }

    }
}