import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/network/stocks_repository.dart';
import 'package:flutter_app/utensil/pigeon.dart';

class DashboardProvider extends ChangeNotifier {
  final AssetsRepository _repository;

  DashboardProvider({required AssetsRepository repository})
      : _repository = repository;

  List<Stock> _stocks = [];

  List<Stock> get chartData => _stocks;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> fetchStocks(String ticker, String function) async {
    try {
      _isLoading = true;
      notifyListeners();
      final fetchedStocks = await _repository.retrieveStocks(ticker, function);
      _stocks = fetchedStocks.whereType<Stock>().toList();
      _stocks = _stocks.reversed.toList();
      _isLoading = false;
      notifyListeners();
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
  }
}

double? minPrice(List<Stock> stock) {
  if (stock.isEmpty) {
    return 0;
  }

  if (stock.length == 1) {
    return stock.first.price ?? 0;
  }

  return stock
      .reduce((previousValue, element) =>
          (previousValue.price ?? 0) < (element.price ?? 0)
              ? previousValue
              : element)
      .price;
}

double? maxPrice(List<Stock> stock) {
  if (stock.isEmpty) {
    return 0;
  }

  if (stock.length == 1) {
    return stock.first.price;
  }

  return stock
      .reduce((previousValue, element) =>
          (previousValue.price ?? 0) > (element.price ?? 0)
              ? previousValue
              : element)
      .price;
}
