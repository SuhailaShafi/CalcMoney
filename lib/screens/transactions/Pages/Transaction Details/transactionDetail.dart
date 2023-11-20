import 'package:evesapp/models/transactionModel/add_date.dart';
import 'package:evesapp/models/categoryModel/category_model.dart';
import 'package:evesapp/screens/transactions/Pages/Transaction%20Details/widgets/details_data.dart';
import 'package:flutter/material.dart';

class TransactionDetailScreen extends StatefulWidget {
  final TransactionModel transaction;
  const TransactionDetailScreen({required this.transaction});
  @override
  State<TransactionDetailScreen> createState() =>
      _TransactionDetailScreenState(transaction: transaction);
}

class _TransactionDetailScreenState extends State<TransactionDetailScreen> {
  final CategoryType categoryType =
      CategoryType.income; // Replace with your actual category type

  String getCategoryTypeString(CategoryType type) {
    String typeString = type.toString();
    return typeString.split('.').last;
  }

  final TransactionModel transaction;
  _TransactionDetailScreenState({required this.transaction});

  DateTime tdate = DateTime.now();
  String? selectedItem;
  String? selectedMode;
  bool validate = false;
  String? theading;
  String? tamount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Transaction Detail'),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: 400,
          color: const Color.fromARGB(255, 227, 250, 248),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TransactionDetailItem('Purpose', transaction.purpose),
              TransactionDetailItem(
                  'CategoryType', getCategoryTypeString(transaction.type)),
              TransactionDetailItem(
                'Category',
                transaction.category.name,
              ),
              TransactionDetailItem('Mode', transaction.mode),
              TransactionDetailItem('Amount', 'Rs:${transaction.amount}'),
            ],
          ),
        ),
      ),
    );
  }
}
