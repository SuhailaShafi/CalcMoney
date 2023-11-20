import 'package:evesapp/db/categorydb.dart';
import 'package:evesapp/models/categoryModel/category_model.dart';
import 'package:evesapp/screens/category/screen/category.dart';
import 'package:flutter/material.dart';

class ExpenseCategoryList extends StatefulWidget {
  const ExpenseCategoryList({super.key});

  @override
  State<ExpenseCategoryList> createState() => _ExpenseCategoryListState();
}

class _ExpenseCategoryListState extends State<ExpenseCategoryList> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDb().expenseCategoryListListner,
      builder: (BuildContext ctx, List<CategoryModel> newList, Widget? _) {
        final filteredList =
            newList.where((category) => !category.isDeleted).toList();

        // Filter out deleted items and user-added items
        final userAddedCategories = newList
            .where((category) =>
                !category.isDeleted &&
                !defaultExpenseCategory.contains(category))
            .toList();

        // Concatenate default items and user-added items
        final mergedList = [...defaultExpenseCategory, ...userAddedCategories];

        // Add default categories to the filtered list if they are not present
        for (final defaultCategory in defaultExpenseCategory) {
          if (!filteredList
              .any((category) => category.id == defaultCategory.id)) {
            filteredList.add(defaultCategory);
          }
        }
        return ListView.builder(
          itemBuilder: (context, index) {
            final category = mergedList[index];
            final isDefaultCategory = defaultExpenseCategory.contains(category);
            return Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Card(
                color: Colors.white,
                elevation: 8,
                child: ListTile(
                  title: Text(category.name),
                  trailing: isDefaultCategory
                      ? null // Remove the delete icon for default items
                      : IconButton(
                          onPressed: () {
                            // Actually delete user-added items
                            ConfirmDeleteMethod(context, category);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                ),
              ),
            );
          },
          itemCount: mergedList.length,
        );
      },
    );
  }

  Future<dynamic> ConfirmDeleteMethod(
      BuildContext context, CategoryModel category) {
    return showDialog(
      context: context,
      builder: (BuildContext contxt) {
        return AlertDialog(
          title: const Text(
            'Confirm Deletion',
          ),
          content: const Text('Are you sure you want to delete this Category?'),
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
                CategoryDb.instance.deleteCategory(category.id);
                Navigator.of(contxt)
                    .pop(); // Close the dialog// Show a Snackbar to confirm the deletion
                showSnackbar(context);
              },
            ),
          ],
        );
      },
    );
  }

  dynamic showSnackbar(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('Category deleted'),
      duration: Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar); // Show the Snackbar
  }
}
