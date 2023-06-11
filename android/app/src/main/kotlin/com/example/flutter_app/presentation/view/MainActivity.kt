package com.example.flutter_app.presentation.view

import android.widget.Toast
import androidx.activity.viewModels
import com.example.flutter_app.presentation.utils.Status
import com.example.flutter_app.presentation.viewmodel.StocksViewModel
import dagger.hilt.android.AndroidEntryPoint
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.Pigeon
import io.flutter.plugins.Pigeon.Stock

@AndroidEntryPoint
class MainActivity : FlutterFragmentActivity() {
    private val viewModel: StocksViewModel by viewModels()

    private inner class MyStockApi : Pigeon.StockApi {
        private var isComplete = false

        override fun getStocks(
            ticker: String,
            function: String,
            result: Pigeon.Result<MutableList<Stock>>?
        ) {
         
            // Set the result and mark it as incomplete
            isComplete = false

            viewModel.getStocks(ticker, "TIME_SERIES_WEEKLY")
            viewModel.stocksInfo.observe(this@MainActivity) {
                when (it.status) {
                    Status.SUCCESS -> {
                        synchronized(isComplete) {
                            it.data?.let { stocks ->
                                    if (stocks.size > 0 && ticker.equals(stocks.get(0).symbol))
                                        result?.success(stocks.toMutableList())

                                }
                            isComplete = true
                        }
                    }
                    Status.LOADING -> {
                        //Loading status handled in Flutter
                    }
                    Status.ERROR -> {
                        //Handle Error
                        isComplete = true
                        it.error?.let { error -> result?.error(error) }
                        Toast.makeText(applicationContext, it.message, Toast.LENGTH_LONG).show()
                    }
                }
            }
        }
    }

    private inner class MyStockInvestApi : Pigeon.StockInvestApi {
        private var isComplete = false
        override fun getStocksInvest(result: Pigeon.Result<MutableList<Pigeon.StockInvest>>?) {
            viewModel.getInvestStocks()
            viewModel.stocksInvestInfo.observe(this@MainActivity) {
                when (it.status) {
                    Status.SUCCESS -> {
                        it.data?.let { stocks -> result?.success(stocks.toMutableList()) }
                        isComplete = true
                    }
                    Status.LOADING -> {
                        //Loading status handled in Flutter
                    }
                    Status.ERROR -> {
                        isComplete = true
                        it.error?.let { error -> result?.error(error) }
                        Toast.makeText(applicationContext, it.message, Toast.LENGTH_LONG).show()
                    }
                }
            }
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        Pigeon.StockApi.setup(
            flutterEngine.dartExecutor.binaryMessenger, MyStockApi()
        )
        Pigeon.StockInvestApi.setup(
            flutterEngine.dartExecutor.binaryMessenger, MyStockInvestApi()
        )
    }
}
