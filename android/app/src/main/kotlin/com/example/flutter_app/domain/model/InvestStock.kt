package com.example.flutter_app.domain.model

import com.google.gson.annotations.SerializedName

data class InvestStock (
    @SerializedName("symbol") val symbol : String,
    @SerializedName("companyName") val companyName : String,
    @SerializedName("avgPrice") val avgPrice : Double,
    @SerializedName("quantity") val quantity : Double,
    @SerializedName("ltp") val ltp : Double
)