import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dashboard/provider/dashboard_provider.dart';
import 'package:flutter_app/holdings/screens/holding_screen.dart';
import 'package:flutter_app/utensil/constants/colors.dart';
import 'package:flutter_app/utensil/constants/shimmers.dart';
import 'package:flutter_app/utensil/constants/text_styles.dart';
import 'package:intl/intl.dart';

class AssetChart extends StatefulWidget {
  final DashboardProvider dashboardProvider;
  const AssetChart(this.dashboardProvider, {super.key});

  @override
  State<AssetChart> createState() => _AssetChartState();
}

class _AssetChartState extends State<AssetChart> {
  double currentChartData = 0;
  String tooltipDate = '';
  final formatCurrency = NumberFormat.simpleCurrency();
  void _onTouch(FlTouchEvent event, LineTouchResponse? response) {
    if (event is FlTapDownEvent ||
        event is FlLongPressMoveUpdate ||
        event is FlPanDownEvent ||
        event is FlPanUpdateEvent) {
      final index = response?.lineBarSpots?.first.x;

      if (index == null) {
        return;
      }

      setState(() {
        tooltipDate =
            widget.dashboardProvider.chartData[index.toInt()].date ?? '';
        currentChartData =
            widget.dashboardProvider.chartData[index.toInt()].price ?? 0;
      });
    } else if (event is FlLongPressEnd ||
        event is FlTapUpEvent ||
        event is FlPanEndEvent) {
      setState(() {
        currentChartData = widget.dashboardProvider.chartData.last.price ?? 0;
        tooltipDate = '';
      });
    }
  }

  Widget title() {
    currentChartData = currentChartData == 0
        ? (widget.dashboardProvider.chartData.last.price ?? 0)
        : currentChartData;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Row(
        children: [
          Text(
            "${widget.dashboardProvider.chartData[0].name}: ",
            textAlign: TextAlign.left,
            style: TextStyles.bold22.withPrimary(),
          ),
          Text(
            formatCurrency.format(currentChartData),
            textAlign: TextAlign.left,
            style: TextStyles.bold22.withPrimary(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.dashboardProvider.chartData.isNotEmpty &&
            !widget.dashboardProvider.isLoading) ...[
          title(),
        ],
        if (widget.dashboardProvider.isLoading)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: boxShimmer(140, double.infinity),
            ),
          ),
        if (widget.dashboardProvider.chartData.isEmpty &&
            !widget.dashboardProvider.isLoading)
          Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  'Please select a stock from above list',
                  style: TextStyles.regular20.withFadeText(),
                ),
              ),
            ],
          ),
        if (!widget.dashboardProvider.isLoading)
          SizedBox(
            width: double.infinity,
            height: 140,
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: widget.dashboardProvider.chartData.length.toDouble() - 1,
                minY: minPrice(widget.dashboardProvider.chartData),
                maxY: maxPrice(widget.dashboardProvider.chartData),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(show: false),
                gridData: FlGridData(show: false),
                lineTouchData: LineTouchData(
                  enabled: true,
                  touchCallback: _onTouch,
                  getTouchedSpotIndicator:
                      (LineChartBarData barData, List<int> indicators) {
                    return indicators.map((int index) {
                      final flLine =
                          FlLine(color: AppColors.accent(), strokeWidth: 0);

                      final dotData = FlDotData(
                        getDotPainter: (spot, percent, bar, index) =>
                            FlDotCirclePainter(
                          radius: 5,
                          color: AppColors.accent(),
                          strokeColor: AppColors.accent(),
                        ),
                      );

                      return TouchedSpotIndicatorData(flLine, dotData);
                    }).toList();
                  },
                  touchTooltipData: LineTouchTooltipData(
                    // maxContentWidth: 0,
                    // tooltipBgColor: Colors.transparent,
                    tooltipPadding: const EdgeInsets.all(4),
                    getTooltipItems: (_) {
                      TextStyle textStyle = TextStyle(
                        color: AppColors.accent(),
                        fontSize: 14,
                      );
                      return [LineTooltipItem(tooltipDate, textStyle)];
                    },
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    color: AppColors.positive(),
                    barWidth: 2,
                    isStrokeCapRound: true,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: AppColors.positive(),
                      gradient: LinearGradient(
                        colors: [
                          AppColors.positive().withOpacity(0),
                          AppColors.positive().withOpacity(0),
                          AppColors.positive().withOpacity(0.75),
                          AppColors.positive()
                        ],
                        begin: const Alignment(.50, 1.70),
                        end: const Alignment(0.5, -0.4),
                      ),
                    ),
                    spots: widget.dashboardProvider.chartData
                        .asMap()
                        .entries
                        .map((entry) {
                      final index = entry.key;
                      final point = entry.value;

                      return FlSpot(index.toDouble(), point.price ?? 0);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        const HoldingScreen(),
      ],
    );
  }
}
