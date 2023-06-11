import 'package:flutter/material.dart';
import 'package:flutter_app/holdings/provider/holdings_provider.dart';
import 'package:flutter_app/utensil/constants/colors.dart';
import 'package:flutter_app/utensil/constants/text_styles.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class MyTotalStats extends StatefulWidget {
  const MyTotalStats({super.key});

  @override
  State<MyTotalStats> createState() => _MyTotalStatsState();
}

class _MyTotalStatsState extends State<MyTotalStats> {
  late HoldingsProvider holdingsProvider;
  final formatCurrency = NumberFormat.simpleCurrency();
  @override
  Widget build(BuildContext context) {
    holdingsProvider = context.watch<HoldingsProvider>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
            'My Holdings',
            style: TextStyles.bold22.textColor(),
          ),
        ),
        Divider(
          height: 2,
          color: AppColors.text(),
        ),
        const SizedBox(
          height: 20,
        ),
        if (holdingsProvider.stocksInvested.isNotEmpty)
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.containerBackground(),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Total Performance: ',
                            style: TextStyles.semibold16.textColor()),
                        Text(
                            '\$${holdingsProvider.totalPnL.toStringAsFixed(2)}',
                            style: TextStyles.semibold16.withPrimary()),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        Text('* till last trading day',
                            style: TextStyles.regular14.textColor()),
                        const SizedBox(width: 28.0),
                        Text(
                            '(${(holdingsProvider.totalPnL / holdingsProvider.totalInvestedAmount * 100).toStringAsFixed(2)}%)',
                            style: TextStyles.semibold14.withFadeText()),
                      ],
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 17),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.containerBackground(),
                  ),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text('Today Performance:',
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: TextStyles.semibold14.textColor()),
                      ),
                      Column(
                        children: [
                          Text(
                              formatCurrency.format((holdingsProvider.todayPnL /
                                  holdingsProvider.totalInvestedAmount *
                                  100)),
                              style: TextStyles.semibold14.withPrimary()),
                          Text(
                              '${holdingsProvider.todayPnL.toStringAsFixed(2)}%',
                              style: TextStyles.semibold14.withPrimary())
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        const SizedBox(
          height: 20,
        ),
        Divider(
          color: AppColors.text(),
          height: 0,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
