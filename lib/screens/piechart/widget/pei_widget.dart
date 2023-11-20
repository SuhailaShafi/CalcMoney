import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:evesapp/db/transactiondb.dart';
import 'package:evesapp/models/transactionModel/add_date.dart';
import 'package:evesapp/models/categoryModel/category_model.dart';

import 'package:month_picker_dialog/month_picker_dialog.dart';

class PieWidget extends StatefulWidget {
  final CategoryType type;
  final DateTime? selectedMonth;
  final DateTimeRange? selectedDateRange;

  const PieWidget(this.type, this.selectedMonth, this.selectedDateRange,
      {Key? key})
      : super(key: key);

  @override
  _PieWidgetState createState() => _PieWidgetState();
}

class _PieWidgetState extends State<PieWidget> {
  Set<String> uniqueEntries = Set();
  List<MapEntry<String, double>> categoryTotalAmountsList = [];
  DateTime? selectedMonth;
  DateTimeRange? selectedDateRange;
  @override
  Widget build(BuildContext context) {
    return ColumnTypeMethod(context, widget.type);
  }

  Column ColumnTypeMethod(BuildContext context, CategoryType type) {
    categoryTotalAmountsList.clear();
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style:
                    const ButtonStyle(elevation: MaterialStatePropertyAll(10)),
                onPressed: () async {
                  DateTime? pickedDate = await showMonthPicker(
                    context: context,
                    initialDate: widget.selectedMonth ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                    selectedMonthBackgroundColor: Colors.teal,
                    roundedCornersRadius: 10,
                  );
                  if (pickedDate != null &&
                      pickedDate != widget.selectedMonth) {
                    setState(() {
                      selectedMonth = pickedDate;
                      selectedDateRange = null;
                    });
                  }
                },
                child: const Text('Select month'),
              ),
              const SizedBox(
                width: 15,
              ),
              ElevatedButton(
                style: const ButtonStyle(
                  elevation: MaterialStatePropertyAll(10),
                ),
                onPressed: () async {
                  DateTimeRange? pickedDateRange = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                    currentDate:
                        widget.selectedDateRange?.start ?? DateTime.now(),
                    initialDateRange: widget.selectedDateRange ??
                        DateTimeRange(
                            start: DateTime.now(), end: DateTime.now()),
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          primaryColor: Colors.teal,
                          colorScheme:
                              const ColorScheme.light(primary: Colors.teal),
                          buttonTheme: const ButtonThemeData(
                            textTheme: ButtonTextTheme.primary,
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (pickedDateRange != null) {
                    setState(() {
                      selectedDateRange = pickedDateRange;
                      selectedMonth = null;
                    });
                  }
                },
                child: const Text('Date range'),
              ),
              const SizedBox(
                width: 15,
              ),
              ElevatedButton(
                style: const ButtonStyle(
                  elevation: MaterialStatePropertyAll(10),
                ),
                onPressed: () async {
                  setState(() {
                    selectedDateRange = null;
                    selectedMonth = null;
                  });
                },
                child: const Text('All'),
              ),
            ],
          ),
        ),
        PieValueListMethod(type, context),
      ],
    );
  }

  Expanded PieValueListMethod(CategoryType type, BuildContext context) {
    return Expanded(
      flex: 4,
      child: ValueListenableBuilder(
        valueListenable: TransactionDB.instance.transactionListNotifier,
        builder:
            (BuildContext ctx, List<TransactionModel> filteredList, Widget? _) {
          // Filter the transactions based on the specified type.
          final filteredTransactions = filteredList
              .where((transaction) => transaction.type == type)
              .toList();
          List<TransactionModel> fil1 = [];
          if (selectedDateRange != null) {
            fil1 = filteredTransactions
                .where((transaction) =>
                    transaction.date.isAfter(selectedDateRange!.start) &&
                    transaction.date.isBefore(selectedDateRange!.end))
                .toList();
          } else if (selectedMonth != null) {
            String monthName = dateTimeToMonthName(selectedMonth!);
            int selectedMonthint = monthNameToNumber(monthName);
            for (TransactionModel transaction in filteredTransactions) {
              if (transaction.date.month == selectedMonthint) {
                fil1.add(transaction);
              }
            }
          } else {
            fil1 = filteredTransactions;
          }
          final Map<String, List<TransactionModel>> transactionsByCategory =
              groupBy(
            fil1,
            (TransactionModel transaction) => transaction.category.name,
          );
          Map<String, double> categoryTotalAmounts = {};

          transactionsByCategory.forEach((category, transactions) {
            double totalAmount = transactions.fold(
                0.0, (sum, transaction) => sum + transaction.amount);
            categoryTotalAmounts[category] = totalAmount;
            // Add the category to the uniqueCategories Set
            uniqueEntries.add(category);
          });
          categoryTotalAmountsList.clear();
          categoryTotalAmounts.forEach((category, totalAmount) {
            categoryTotalAmountsList.add(MapEntry(category, totalAmount));
          });

          // Sort the list in decreasing order of total amount
          categoryTotalAmountsList.sort((a, b) => b.value.compareTo(a.value));

          Map<String, double> pieData = categoryTotalAmounts;
          if (pieData.isNotEmpty) {
            return BuildChartMethod(pieData, context, type, fil1);
          } else {
            return const Text("No data to display");
          }
        },
      ),
    );
  }

  Column BuildChartMethod(Map<String, double> pieData, BuildContext context,
      CategoryType type, List<TransactionModel> fil1) {
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: PieChart(
            dataMap: pieData,
            animationDuration: const Duration(milliseconds: 800),
            chartLegendSpacing: 32,
            chartRadius: MediaQuery.of(context).size.width / 2,
            initialAngleInDegree: 0,
            chartType: ChartType.ring,
            ringStrokeWidth: 32,
            legendOptions: const LegendOptions(
              showLegendsInRow: false,
              legendPosition: LegendPosition.right,
              showLegends: true,
              legendShape: BoxShape.circle,
              legendTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            chartValuesOptions: const ChartValuesOptions(
              showChartValueBackground: true,
              showChartValues: true,
              showChartValuesInPercentage: true,
              showChartValuesOutside: false,
              decimalPlaces: 1,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          flex: 1,
          child: Text(
            type == CategoryType.expense ? 'Top Spending' : 'Top Earning',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        // Display a list of top spending categories
        Expanded(
          flex: 4,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: categoryTotalAmountsList.length,
              itemBuilder: (context, index) {
                final entry = categoryTotalAmountsList[index];
                return Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: GestureDetector(
                    onTap: () {
                      ViewTransListDialogMethod(context, fil1, entry.key);
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(
                          entry.key,
                          style: TextStyle(fontSize: 16),
                        ),
                        trailing: Text(
                          'Rs:${entry.value.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }

  Future<dynamic> ViewTransListDialogMethod(
      BuildContext context, List<TransactionModel> fil1, String category) {
    List<TransactionModel> fil2 = fil1
        .where((transaction) => transaction.category.name == category)
        .toList();
    double totalHeight = fil2.length * 60.0;
    return showDialog(
      context: context,
      builder: (BuildContext contxt) {
        return AlertDialog(
          backgroundColor: Colors.teal,
          title: const Center(child: Text('Transactions')),
          content: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              height: totalHeight,
              width: double.maxFinite,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: fil2.length,
                  itemBuilder: (context, index) {
                    final entry = fil2[index];
                    final formattedDate =
                        DateFormat('dd MMM yyyy').format(entry.date);

                    return ListTile(
                      title: Text(entry.purpose),
                      trailing: Text(formattedDate),
                    );
                  }),
            ),
          ),
        );
      },
    );
  }

  int monthNameToNumber(String monthName) {
    final dateTime = DateFormat.MMMM().parse(monthName);
    return dateTime.month;
  }

  String dateTimeToMonthName(DateTime dateTime) {
    final format = DateFormat.MMMM(); // Format to get the full month name
    return format.format(dateTime);
  }
}
