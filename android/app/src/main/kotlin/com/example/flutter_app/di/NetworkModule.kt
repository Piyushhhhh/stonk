package com.example.flutter_app.di

import com.example.flutter_app.data.datasource.api.StocksInvestService
import com.example.flutter_app.data.datasource.api.StocksService
import com.example.flutter_app.domain.model.StockInfos
import com.example.flutter_app.domain.model.WeeklyTimeSeriesDeserializer
import com.google.gson.*
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import javax.inject.Named
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
object NetworkModule {

    @Provides
    fun provideBaseUrl() = "https://www.alphavantage.co/"

    @Provides
    fun provideGson(): Gson = GsonBuilder()
        .registerTypeAdapter(StockInfos::class.java, WeeklyTimeSeriesDeserializer())
        .create()

    @Provides
    fun provideOkHttpClient(): OkHttpClient = OkHttpClient.Builder().build()

    @Provides
    fun provideRetrofit(gson: Gson): Retrofit {
        val interceptor = HttpLoggingInterceptor()
        interceptor.setLevel(HttpLoggingInterceptor.Level.BODY)
        val client = OkHttpClient.Builder().addInterceptor(interceptor).build()

        return Retrofit.Builder()
            .baseUrl("https://www.alphavantage.co/")
            .addConverterFactory(GsonConverterFactory.create(gson))
            .client(client)
            .build()
    }

    @Provides
    @Named("Api2")
    fun provideRetrofitInvest(): Retrofit {
        val interceptor = HttpLoggingInterceptor()
        interceptor.setLevel(HttpLoggingInterceptor.Level.BODY)
        val client = OkHttpClient.Builder().addInterceptor(interceptor).build()

        return Retrofit.Builder()
            .baseUrl("https://run.mocky.io/v3/2b63ba43-6440-4780-aa13-91e6d8247305/")
            .addConverterFactory(GsonConverterFactory.create(GsonBuilder().create()))
            .client(client)
            .build()
    }

    @Provides
    @Singleton
    fun provideAlphaVantageApi(retrofit: Retrofit): StocksService {
        return retrofit.create(StocksService::class.java)
    }

    @Provides
    @Singleton
    fun provideInvestmentApi(@Named("Api2") retrofit: Retrofit): StocksInvestService {
        return retrofit.create(StocksInvestService::class.java)
    }
}