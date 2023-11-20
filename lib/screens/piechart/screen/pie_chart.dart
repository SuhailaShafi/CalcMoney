import 'package:evesapp/screens/piechart/widget/pei_widget.dart';
import 'package:flutter/material.dart';

import 'package:evesapp/models/categoryModel/category_model.dart';

class PienewChart extends StatefulWidget {
  const PienewChart({Key? key});

  @override
  _PienewChartState createState() => _PienewChartState();
}

class _PienewChartState extends State<PienewChart> {
  List<MapEntry<String, double>> categoryTotalAmountsList = [];
  DateTime? selectedMonth;
  DateTimeRange? selectedDateRange;

  @override
  Widget build(BuildContext context) {
    categoryTotalAmountsList.clear();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          bottom: const TabBar(
            labelColor: Colors.white,
            tabs: [
              Tab(
                text: 'Income',
              ),
              Tab(
                text: 'Expense',
              ),
            ],
          ),
          title: const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Statistics'),
            ),
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              PieWidget(CategoryType.income, selectedMonth, selectedDateRange),
              PieWidget(CategoryType.expense, selectedMonth, selectedDateRange),
            ],
          ),
        ),
      ),
    );
  }
}
