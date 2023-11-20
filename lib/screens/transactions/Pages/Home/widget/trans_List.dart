import 'package:evesapp/models/categoryModel/category_model.dart';
import 'package:evesapp/models/transactionModel/add_date.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionListWidget extends StatelessWidget {
  const TransactionListWidget({
    super.key,
    required List<TransactionModel> filteredTransactions,
  }) : _filteredTransactions = filteredTransactions;

  final List<TransactionModel> _filteredTransactions;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _filteredTransactions.length,
      itemBuilder: (context, index) {
        final _value = _filteredTransactions[index];
        return Card(
          elevation: 8,
          color: Colors.white,
          child: ListTile(
            leading: CircleAvatar(
              radius: 50,
              backgroundColor: _value.type == CategoryType.income
                  ? Colors.green
                  : Colors.red,
              child: Text(
                parseDate(_value.date),
                textAlign: TextAlign.center,
              ),
            ),
            title: Text(_value.category.name),
            trailing: Text(
              'Rs:${_value.amount}',
              style: TextStyle(
                color: _value.type == CategoryType.income
                    ? Colors.green
                    : Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Text(_value.purpose),
          ),
        );
      },
    );
  }

  String parseDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _splitdate = _date.split(' ');
    return '${_splitdate.last}\n${_splitdate.first}';
  }
}
