import 'package:flutter/material.dart';

import 'package:flutter_app/data/network/stocks_invested_repository.dart';
import 'package:flutter_app/holdings/widgets/holding_list.dart';
import 'package:flutter_app/holdings/provider/holdings_provider.dart';
import 'package:provider/provider.dart';

import '../../utensil/pigeon.dart';

class HoldingScreen extends StatelessWidget {
  const HoldingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final api = GetInvestedStock();
    final investRepository = HoldingsRepository(stockService: api);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<HoldingsProvider>(
          create: (_) => HoldingsProvider(repository: investRepository),
        ),
      ],
      child: const HoldingList(),
    );
  }
}
