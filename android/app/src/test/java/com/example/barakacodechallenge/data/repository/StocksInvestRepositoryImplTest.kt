package com.example.barakacodechallenge.data.repository

import com.example.flutter_app.data.datasource.api.StocksInvestService
import com.example.flutter_app.data.mapper.NetworkToDomainListStockInvestMapper
import com.example.flutter_app.data.model.StockInvestResult
import com.example.flutter_app.data.repository.StocksInvestRepositoryImpl
import com.example.flutter_app.domain.model.InvestedStocks
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
class StocksInvestRepositoryImplTest {

    @Mock
    private lateinit var stocksInvestedStocks: InvestedStocks

    @Mock
    private lateinit var pigeonInvestedStocks: List<Pigeon.StockInvest>

    @Mock
    private lateinit var responseInvestedStocks: Response<InvestedStocks>

    @Mock
    private lateinit var stocksInvestService: StocksInvestService

    @Mock
    private lateinit var mapper: NetworkToDomainListStockInvestMapper

    private lateinit var sut: StocksInvestRepositoryImpl

    @Before
    fun setUp() {
        sut = StocksInvestRepositoryImpl(stocksInvestService, mapper)
    }

    @Test
    fun getStocksInvest() {
        runBlocking {
            whenever(responseInvestedStocks.isSuccessful).thenReturn(true)
            whenever(responseInvestedStocks.body()).thenReturn(stocksInvestedStocks)
            whenever(stocksInvestService.getInvestedStocks()).thenReturn(responseInvestedStocks)
            whenever(stocksInvestService.getInvestedStocks().body()).thenReturn(stocksInvestedStocks)
            whenever(mapper.map(stocksInvestedStocks.stocks)).thenReturn(pigeonInvestedStocks)

            val result = sut.getStocksInvest()
            assertTrue(result is StockInvestResult.Success)
        }
    }
}