import 'package:evesapp/models/transactionModel/add_date.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter/foundation.dart';

const TRANSACTION_DB_NAME = 'transaction-db';

abstract class TransactionDbFunctions {
  Future<void> addTransaction(TransactionModel obj);
  Future<List<TransactionModel>> getAllTransactions();
  Future<void> deleteTransaction(String id);
}

class TransactionDB extends ChangeNotifier implements TransactionDbFunctions {
  TransactionDB._internal();
  static TransactionDB instance = TransactionDB._internal();
  factory TransactionDB() {
    return instance;
  }
  ValueNotifier<List<TransactionModel>> transactionListNotifier =
      ValueNotifier([]);
  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await db.put(obj.id, obj);

    refresh();
  }

  Future<void> refresh() async {
    final list = await getAllTransactions();
    list.sort((first, second) => second.date.compareTo(first.date));
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(list);
    transactionListNotifier.notifyListeners();
  }

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return db.values.toList();
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await db.delete(id);
    refresh();
  }

  Future<void> editTransaction(
      String id, TransactionModel updatedTransaction) async {
    final db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);

    if (db.containsKey(id)) {
      await db.put(id, updatedTransaction);
    } else {}

    // Refresh the transaction list
    refresh();
  }
}
