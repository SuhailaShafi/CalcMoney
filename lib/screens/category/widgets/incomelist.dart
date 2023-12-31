import 'package:evesapp/db/categorydb.dart';
import 'package:evesapp/models/categoryModel/category_model.dart';
import 'package:evesapp/screens/category/screen/category.dart';
import 'package:flutter/material.dart';

class IncomeCategoryList extends StatefulWidget {
  const IncomeCategoryList({super.key});

  @override
  State<IncomeCategoryList> createState() => _IncomeCategoryListState();
}

class _IncomeCategoryListState extends State<IncomeCategoryList> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDb().incomeCategoryListListner,
      builder: (BuildContext ctx, List<CategoryModel> newList, Widget? _) {
        final filteredList =
            newList.where((category) => !category.isDeleted).toList();

        // Filter out deleted items and user-added items
        final userAddedCategories = newList
            .where((category) =>
                !category.isDeleted && !defaultCategories.contains(category))
            .toList();

        // Concatenate default items and user-added items
        final mergedList = [...defaultCategories, ...userAddedCategories];

        // Add default categories to the filtered list if they are not present
        for (final defaultCategory in defaultCategories) {
          if (!filteredList
              .any((category) => category.id == defaultCategory.id)) {
            filteredList.add(defaultCategory);
          }
        }

        return ListView.builder(
          itemBuilder: (context, index) {
            final category = mergedList[index];
            final isDefaultCategory = defaultCategories.contains(category);
            return Padding(
              padding: const EdgeInsets.only(left: 15.0),
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
      BuildContext ctx, CategoryModel category) {
    return showDialog(
      context: ctx,
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
                showSnackbar(ctx);
              },
            ),
          ],
        );
      },
    );
  }

  dynamic showSnackbar(BuildContext ctx) {
    const snackBar = SnackBar(
      content: Text('Category deleted'),
      duration: Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(ctx).showSnackBar(snackBar); // Show the Snackbar
  }
}
