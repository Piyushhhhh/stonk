import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dashboard/provider/dashboard_provider.dart';
import 'package:flutter_app/dashboard/widgets/chart.dart';
import 'package:flutter_app/data/network/stock_suggestion.dart';
import 'package:flutter_app/utensil/constants/colors.dart';
import 'package:flutter_app/utensil/constants/text_styles.dart';
import 'package:flutter_app/utensil/pigeon.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Stock> listStock = [];
  String searchValue = '';

  late DashboardProvider dashboardProvider;

  @override
  Widget build(BuildContext context) {
    dashboardProvider = context.watch<DashboardProvider>();
    return Consumer<DashboardProvider>(
      builder: (context, model, child) => GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          backgroundColor: AppColors.background(),
          appBar: EasySearchBar(
            titleTextStyle: TextStyles.bold22.textColor(),
            searchTextStyle: TextStyles.bold22.textColor(),
            backgroundColor: AppColors.background(),
            iconTheme: IconThemeData(color: AppColors.accent()),
            elevation: 0,
            suggestionBackgroundColor: AppColors.containerBackground(),
            searchBackgroundColor: AppColors.containerBackground(),
            searchCursorColor: AppColors.primary(),
            suggestionTextStyle: TextStyles.semibold20.withFadeText(),
            searchBackIconTheme: IconThemeData(color: AppColors.accent()),
            searchClearIconTheme: IconThemeData(color: AppColors.accent()),
            suggestionBuilder: (data) {
              return ListTile(
                leading: Icon(
                  Icons.travel_explore_outlined,
                  color: AppColors.accent(),
                ),
                title: Text(
                  data,
                  style: TextStyles.semibold20.withFadeText(),
                ),
              );
            },
            title: Text(
              'Search Stocks',
              style: TextStyles.bold22.textColor(),
            ),
            onSuggestionTap: (data) async {
              FocusScope.of(context).unfocus();
              await dashboardProvider.fetchStocks(data, "TIME_SERIES_WEEKLY");
            },
            onSearch: (value) => setState(() => searchValue = value),
            suggestions: suggestions,
          ),
          body: SingleChildScrollView(child: AssetChart(dashboardProvider)),
        ),
      ),
    );
  }
}
