import 'package:evesapp/db/transactiondb.dart';
import 'package:evesapp/models/categoryModel/category_model.dart';
import 'package:evesapp/models/transactionModel/add_date.dart';
import 'package:evesapp/screens/transactions/Pages/Edit%20Transaction/edit_transaction.dart';
import 'package:evesapp/screens/transactions/Pages/Transaction%20Details/transactionDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class TypeListWidget extends StatelessWidget {
  const TypeListWidget({
    super.key,
    required this.ctr,
    required this.fil1,
  });

  final ScrollController ctr;
  final List<TransactionModel> fil1;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: ctr,
      padding: const EdgeInsets.all(3),
      itemBuilder: (ctx, liindex) {
        final _value = fil1[liindex];

        return Slidable(
          key: Key(_value.id),
          startActionPane: ActionPane(motion: const ScrollMotion(), children: [
            SlidableAction(
              onPressed: (ctx) {
                showDialog(
                  context: context,
                  builder: (BuildContext contxt) {
                    return AlertDialog(
                      title: const Text(
                        'Confirm Deletion',
                      ),
                      content: const Text(
                          'Are you sure you want to delete this transaction?'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            Navigator.of(contxt).pop(); // Close the dialog
                          },
                        ),
                        TextButton(
                          child: const Text('Delete'),
                          onPressed: () {
                            // Delete the transaction here
                            TransactionDB.instance.deleteTransaction(_value.id);
                            Navigator.of(contxt)
                                .pop(); // Close the dialog// Show a Snackbar to confirm the deletion
                            const snackBar = SnackBar(
                              content: Text('Transaction deleted'),
                              duration: Duration(seconds: 2),
                              behavior: SnackBarBehavior.floating,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              onPressed: (ctx) {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx1) {
                  return EditScreen(
                    transaction: fil1[liindex],
                  );
                }));
              },
              icon: Icons.edit,
              label: 'Edit',
            )
          ]),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TransactionDetailScreen(
                  transaction: fil1[liindex],
                ),
              ));
            },
            child: Card(
              color: Colors.white,
              elevation: 8,
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
                      fontSize: 16),
                ),
                subtitle: Text(_value.purpose),
              ),
            ),
          ),
        );
        // ...
      },
      separatorBuilder: (ctx, index) {
        return const SizedBox(height: 10);
      },
      itemCount: fil1.length,
    );
  }

  String parseDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _splitdate = _date.split(' ');
    return '${_splitdate.last}\n${_splitdate.first}';
  }
}
