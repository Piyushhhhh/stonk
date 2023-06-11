package com.example.flutter_app.domain.model

import com.google.gson.JsonDeserializationContext
import com.google.gson.JsonDeserializer
import com.google.gson.JsonElement
import com.google.gson.annotations.SerializedName
import java.lang.reflect.Type

data class StockInfos(
    @SerializedName("Meta Data") val metaData: MetaData,
    val timeSeries: TimeSeries
)

data class MetaData(
    @SerializedName("1. Information") val information: String,
    @SerializedName("2. Symbol") val symbol: String,
    @SerializedName("3. Last Refreshed") val lastRefreshed: String,
    @SerializedName("4. Time Zone") val timeZone: String
)

data class TimeSeries(
    @SerializedName("Weekly Time Series") val timeSeriesData: Map<String, List<TimeSeriesData>>
)

data class TimeSeriesData(
    @SerializedName("1. open") val open: String,
    @SerializedName("2. high") val high: String,
    @SerializedName("3. low") val low: String,
    @SerializedName("4. close") val close: String,
    @SerializedName("5. volume") val volume: String,
    val date: String
)

class WeeklyTimeSeriesDeserializer : JsonDeserializer<StockInfos> {
    override fun deserialize(
        json: JsonElement?,
        typeOfT: Type?,
        context: JsonDeserializationContext?
    ): StockInfos {
        val stockObject = json!!.asJsonObject
        val metaDataObject = stockObject.get("Meta Data").asJsonObject

        val information = metaDataObject.get("1. Information").asString
        val symbol = metaDataObject.get("2. Symbol").asString
        val lastRefreshed = metaDataObject.get("3. Last Refreshed").asString
        val timeZone = metaDataObject.get("4. Time Zone").asString
        val metaData = MetaData(information, symbol, lastRefreshed, timeZone)

        val weeklyPricesObject = stockObject.get("Weekly Time Series").asJsonObject
        val timeSeriesData: Map<String, List<TimeSeriesData>> =
            weeklyPricesObject.entrySet().associate { entry ->
                val date = entry.key
                val weeklyPrices = listOf(
                    context!!.deserialize<TimeSeriesData>(entry.value, TimeSeriesData::class.java)
                        .copy(date = date)
                )
                date to weeklyPrices
            }

        val timeSeries = TimeSeries(timeSeriesData)
        return StockInfos(metaData, timeSeries)
    }
}