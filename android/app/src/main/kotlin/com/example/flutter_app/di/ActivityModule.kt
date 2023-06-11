package com.example.flutter_app.di

import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.ViewModelStoreOwner
import com.example.flutter_app.presentation.viewmodel.StocksViewModel
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.components.ActivityComponent

@Module
@InstallIn(ActivityComponent::class)
object MyActivityModule {

    @Provides
    fun provideMyViewModel(
        factory: ViewModelProvider.Factory,
        owner: ViewModelStoreOwner
    ): StocksViewModel {
        return ViewModelProvider(owner, factory)[StocksViewModel::class.java]
    }
}
