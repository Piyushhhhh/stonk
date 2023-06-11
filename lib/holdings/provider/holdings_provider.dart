import 'package:flutter/material.dart';
import 'package:flutter_app/data/network/stocks_invested_repository.dart';
import 'package:flutter_app/utensil/pigeon.dart';

class HoldingsProvider extends ChangeNotifier {
  late final HoldingsRepository _repository;

  List<StockInvest> stocksInvested = [];

  HoldingsProvider({required HoldingsRepository repository}) {
    _repository = repository;
    if (stocksInvested.isEmpty) fetchInvestedStocks();
  }

  bool isLoading = false;

  double totalInvestedAmount = 0;

  double totalLastPrice = 0;

  double totalPnL = 0;
  double todayPnL = 0;

  fetchInvestedStocks() async {
    try {
      isLoading = true;
      notifyListeners();
      final fetchedStocks = await _repository.retrieveInvestedStocks();
      stocksInvested = fetchedStocks.whereType<StockInvest>().toList();
      calculateTotals();
      isLoading = false;
      notifyListeners();
    } catch (error) {
      isLoading = false;
      notifyListeners();
      rethrow;
    }
  }

  void calculateTotals() {
    for (StockInvest stock in stocksInvested) {
      totalInvestedAmount += stock.investedTotal ?? 0;
      totalLastPrice += stock.currentValue ?? 0;
      todayPnL += stock.pl ?? 0;
    }
    totalPnL = totalLastPrice - totalInvestedAmount;
  }
}
