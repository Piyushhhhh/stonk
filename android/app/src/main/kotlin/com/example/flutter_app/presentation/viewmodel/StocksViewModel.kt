package com.example.flutter_app.presentation.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.flutter_app.data.model.StockInvestResult
import com.example.flutter_app.data.model.StockResult
import com.example.flutter_app.domain.usecase.GetInvestStocksUseCase
import com.example.flutter_app.domain.usecase.GetStocksUseCase
import com.example.flutter_app.presentation.utils.Resource
import dagger.hilt.android.lifecycle.HiltViewModel
import io.flutter.plugins.Pigeon
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class StocksViewModel @Inject constructor(
    private val getStocksUseCase: GetStocksUseCase,
    private val getInvestStocksUseCase: GetInvestStocksUseCase,
) : ViewModel() {

    private val _stocksInfo: MutableLiveData<Resource<List<Pigeon.Stock>>> = MutableLiveData()
    val stocksInfo: LiveData<Resource<List<Pigeon.Stock>>>
        get() = _stocksInfo

    private val _stocksInvestInfo: MutableLiveData<Resource<List<Pigeon.StockInvest>>> =
        MutableLiveData()
    val stocksInvestInfo: LiveData<Resource<List<Pigeon.StockInvest>>>
        get() = _stocksInvestInfo

    fun getStocks(ticker: String, function: String) {
        viewModelScope.launch {
            getStocksUseCase(ticker).also {
                when (it) {
                    is StockResult.Success -> {
                        _stocksInfo.postValue(Resource.success(it.data))
                    }
                    is StockResult.Failure -> {
                        _stocksInfo.postValue(Resource.error(it.message, it.error))
                    }
                }
            }
        }
    }

    fun getInvestStocks() {
        viewModelScope.launch {
            getInvestStocksUseCase().also {
                when (it) {
                    is StockInvestResult.Success -> {
                        _stocksInvestInfo.postValue(Resource.success(it.data))
                    }
                    is StockInvestResult.Failure -> {
                        _stocksInvestInfo.postValue(Resource.error(it.message, it.error))
                    }
                }
            }
        }
    }
}