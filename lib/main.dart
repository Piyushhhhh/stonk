import 'package:flutter/material.dart';
import 'package:flutter_app/data/network/stocks_repository.dart';
import 'package:flutter_app/dashboard/provider/dashboard_provider.dart';
import 'package:flutter_app/utensil/pigeon.dart';
import 'package:provider/provider.dart';
import 'dashboard/screens/dashboard.dart';

void main() {
  runApp(const MyHomePage());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final api = StockApi();
    final repository = AssetsRepository(stockService: api);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DashboardProvider>(
          create: (_) => DashboardProvider(repository: repository),
        ),
      ],
      child: const MaterialApp(home: Dashboard()),
    );
  }
}
