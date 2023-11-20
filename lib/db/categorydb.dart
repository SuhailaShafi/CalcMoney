import 'package:evesapp/models/categoryModel/category_model.dart';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: constant_identifier_names
const CATEGORY_DB_NAME = 'category-database';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deleteCategory(String categoryID);
}

class CategoryDb implements CategoryDbFunctions {
  CategoryDb.internal() {
    // _initializeDefaultCategories();
  }

  static CategoryDb instance = CategoryDb.internal();

  factory CategoryDb() {
    return CategoryDb.instance;
  }

  ValueNotifier<List<CategoryModel>> incomeCategoryListListner =
      ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryListListner =
      ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    if (!categoryDB.containsKey(value.id)) {
      await categoryDB.put(value.id, value);
      refreshUI();
    }
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return categoryDB.values.toList();
  }

  Future<void> refreshUI() async {
    final allCategories = await getCategories();
    incomeCategoryListListner.value.clear();
    expenseCategoryListListner.value.clear();

    await Future.forEach(
      allCategories,
      (CategoryModel category) {
        if (category.type == CategoryType.income) {
          incomeCategoryListListner.value.add(category);
        } else {
          expenseCategoryListListner.value.add(category);
        }
      },
    );

    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    incomeCategoryListListner.notifyListeners();
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    expenseCategoryListListner.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String categoryID) async {
    final categoryDb = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await categoryDb.delete(categoryID);
    refreshUI();
  }
}
