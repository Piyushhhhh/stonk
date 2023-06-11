import 'package:pigeon/pigeon.dart';

class Stock {
  String? symbol;
  String? name;
  double? price;
  String? date;
  double? change;
  double? percentChange;
}

class StockInvest {
  String? symbol;
  String? name;
  double? investedTotal;
  double? quantity;
  double? currentValue;
  double? pl;
  double? percentagePL;
  double? averagePrice;
  double? ltp;
}

@HostApi()
abstract class StockApi {
  @async
  List<Stock?> getStocks(String ticker, String function);
}

@HostApi()
abstract class StockInvestApi {
  @async
  List<StockInvest?> getStocksInvest();
}

@HostApi()
abstract class MyApi {
  @async
  MyResponse getStocksInfo(MyRequest request);
}

class MyRequest {
  String? id;
  String? ticker;
  String? function;
}

class MyResponse {
  String? id;
  List<Stock?>? result;
}
