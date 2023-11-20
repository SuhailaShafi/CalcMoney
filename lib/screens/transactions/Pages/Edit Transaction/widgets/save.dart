import 'package:evesapp/db/transactiondb.dart';
import 'package:evesapp/models/categoryModel/category_model.dart';
import 'package:evesapp/models/transactionModel/add_date.dart';
import 'package:flutter/material.dart';

class SaveWidget extends StatelessWidget {
  const SaveWidget({
    super.key,
    required this.headingC,
    required this.amountC,
    required String? categoryID,
    required this.transaction,
    required this.date,
    required CategoryType? selectedCategoryType,
    required CategoryModel? selectedCategoryModel,
    required this.selectedMode,
  })  : _categoryID = categoryID,
        _selectedCategoryType = selectedCategoryType,
        _selectedCategoryModel = selectedCategoryModel;

  final TextEditingController? headingC;
  final TextEditingController? amountC;
  final String? _categoryID;
  final TransactionModel transaction;
  final DateTime date;
  final CategoryType? _selectedCategoryType;
  final CategoryModel? _selectedCategoryModel;
  final String? selectedMode;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final _purposetxt = headingC!.text;
        final _amountText = amountC!.text;
        if (_purposetxt.isEmpty || _amountText.isEmpty || _categoryID == null) {
          return;
        }
        final parsedamount = double.tryParse(_amountText);
        if (parsedamount == null) {
          return;
        }
        String id = transaction.id;
        final updatedTransaction = TransactionModel(
          // Include the ID of the existing transaction
          purpose: _purposetxt,
          amount: parsedamount,
          date: date,
          type: _selectedCategoryType!,
          category: _selectedCategoryModel!,
          mode: selectedMode!,
          id: id,
        );
// Use the Hive box to update the transaction

        TransactionDB.instance
            .editTransaction(transaction.id, updatedTransaction);
        Navigator.of(context).pop();
      },
      child: Container(
        width: 120,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black,
        ),
        child: Text(
          'Save',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
