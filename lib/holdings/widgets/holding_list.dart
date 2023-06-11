import 'package:flutter/material.dart';
import 'package:flutter_app/holdings/widgets/holding_stats.dart';
import 'package:flutter_app/holdings/provider/holdings_provider.dart';
import 'package:flutter_app/utensil/constants/colors.dart';
import 'package:flutter_app/utensil/constants/shimmers.dart';
import 'package:flutter_app/utensil/constants/text_styles.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../utensil/pigeon.dart';

class HoldingList extends StatefulWidget {
  const HoldingList({super.key});

  @override
  HoldingListState createState() => HoldingListState();
}

class HoldingListState extends State<HoldingList> {
  late HoldingsProvider stocksInvestViewModel;
  final formatCurrency = NumberFormat.simpleCurrency();

  @override
  void initState() {
    // stocksInvestViewModel.fetchInvestedStocks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    stocksInvestViewModel = context.watch<HoldingsProvider>();
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: stocksInvestViewModel.isLoading
          ? Column(
              children: [
                shimmerList(),
                shimmerList(),
                shimmerList(),
              ],
            )
          : Column(
              children: [
                const MyTotalStats(),
                if (stocksInvestViewModel.stocksInvested.isNotEmpty)
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 30),
                    shrinkWrap: true,
                    itemCount: stocksInvestViewModel.stocksInvested.length,
                    itemBuilder: (BuildContext context, int index) {
                      StockInvest stock =
                          stocksInvestViewModel.stocksInvested[index];
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                            color: AppColors.containerBackground(),
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(stock.name ?? '',
                                    style: TextStyles.bold20.textColor()),
                                Row(
                                  children: [
                                    Text(
                                      formatCurrency.format(stock.pl),
                                      style: (stock.pl ?? 0) > 0
                                          ? TextStyles.semibold16.withPrimary()
                                          : TextStyles.semibold16
                                              .withNegative(),
                                    ),
                                    Text(
                                      ' (${stock.percentagePL?.toStringAsFixed(2)}%)',
                                      style: TextStyles.semibold14.textColor(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    'Invested ${formatCurrency.format(stock.investedTotal)}',
                                    style: TextStyles.regular14.textColor()),
                                Text(
                                  '${formatCurrency.format(stock.averagePrice)} Avg',
                                  style: TextStyles.regular14.textColor(),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Quantity \$${stock.quantity}',
                                    style: TextStyles.regular14.textColor()),
                                Text(
                                  '${formatCurrency.format(stock.ltp)} LTP',
                                  style: TextStyles.regular14.textColor(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
              ],
            ),
    );
  }
}
