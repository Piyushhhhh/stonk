package com.example.flutter_app.domain.model

import com.google.gson.annotations.SerializedName

data class InvestedStocks(@SerializedName("stocks") val stocks: List<InvestStock>)
