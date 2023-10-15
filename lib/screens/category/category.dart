// ignore_for_file: prefer_const_constructors, unused_import

import 'package:evesapp/models/category_model.dart';
import 'package:evesapp/screens/category/addcategory.dart';
import 'package:flutter/material.dart';

import 'package:evesapp/db/categorydb.dart';
import 'package:evesapp/screens/category/expenselist.dart';
import 'package:evesapp/screens/category/incomelist.dart';
import 'package:evesapp/screens/bottomnavigation.dart';

final defaultCategories = [
  CategoryModel(
      id: '1', name: 'Salary', type: CategoryType.income, isDeleted: false),
  CategoryModel(
      id: '2', name: 'Allowence', type: CategoryType.income, isDeleted: false),
];

final defaultExpenseCategory = [
  CategoryModel(
      id: '4', name: 'Food', type: CategoryType.expense, isDeleted: false),
  CategoryModel(
      id: '3',
      name: 'Entertainment',
      type: CategoryType.expense,
      isDeleted: false),
];

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDb().refreshUI();
    super.initState();
  }

  int indexTypeColor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Column(
          children: [
            topBar(),
            TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              tabs: const [
                Tab(
                  child: Text(
                    'Income',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                Tab(
                  text: 'Expense',
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  IncomeCategoryList(),
                  ExpenseCategoryList(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding topBar() {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Category',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
