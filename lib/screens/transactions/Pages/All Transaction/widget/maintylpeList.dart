import 'package:evesapp/db/transactiondb.dart';
import 'package:evesapp/models/categoryModel/category_model.dart';
import 'package:evesapp/models/transactionModel/add_date.dart';
import 'package:evesapp/screens/transactions/Pages/All%20Transaction/widget/typeListWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class typeListMethodWidget extends StatelessWidget {
  const typeListMethodWidget({
    super.key,
    required this.ctr,
    required this.context,
    required this.type,
    required this.searchQuery,
    required this.selectedDateRange,
    required this.selectedMonth,
  });

  final ScrollController ctr;
  final BuildContext context;
  final CategoryType type;
  final String searchQuery;
  final DateTimeRange? selectedDateRange;
  final DateTime? selectedMonth;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: TransactionDB.instance.transactionListNotifier,
      builder:
          (BuildContext ctx, List<TransactionModel> filteredList, Widget? _) {
        // Filter the transactions based on the specified type and search query.
        final filteredTransactions = filteredList.where((transaction) {
          final transactionTitle = transaction.category.name.toLowerCase();
          final isTypeMatch = transaction.type == type;
          final isSearchMatch = searchQuery.isEmpty ||
              transactionTitle.contains(searchQuery.toLowerCase());

          return isTypeMatch && isSearchMatch;
        }).toList();
        List<TransactionModel> fil1 = [];
        if (selectedDateRange != null) {
          fil1 = filteredTransactions
              .where((transaction) =>
                  transaction.date.isAfter(selectedDateRange!.start) &&
                  //transaction.date.isAtSameMomentAs(selectedDateRange.start)
                  transaction.date.isBefore(selectedDateRange!.end))
              //transaction.date.isAtSameMomentAs(selectedDateRange.end))
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

        if (fil1.isNotEmpty) {
          return TypeListWidget(ctr: ctr, fil1: fil1);
        } else {
          return Center(child: Text('No data to display'));
        }
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
