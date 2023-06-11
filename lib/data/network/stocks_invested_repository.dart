import 'package:flutter_app/utensil/pigeon.dart';

class HoldingsRepository {
  final GetInvestedStock stockService;

  HoldingsRepository({required this.stockService});

  Future<List<StockInvest?>> retrieveInvestedStocks() async {
    final fetchedInvestedStocks = await stockService.getStocksInvest();
    return fetchedInvestedStocks.whereType<StockInvest>().toList();
  }
}
