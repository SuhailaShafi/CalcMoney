// ignore_for_file: prefer_const_constructors, unused_import

import 'package:evesapp/models/categoryModel/category_model.dart';
import 'package:evesapp/screens/category/screen/addcategory.dart';
import 'package:flutter/material.dart';

import 'package:evesapp/db/categorydb.dart';
import 'package:evesapp/screens/category/widgets/expenselist.dart';
import 'package:evesapp/screens/category/widgets/incomelist.dart';
import 'package:evesapp/screens/bottomnavigation.dart';

final defaultCategories = [
  CategoryModel(
      id: '1', name: 'Salary', type: CategoryType.income, isDeleted: false),
  CategoryModel(
      id: '2', name: 'Allowance', type: CategoryType.income, isDeleted: false),
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
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: topBar(),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
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
      ),
      extendBody: true,
      backgroundColor: Color.fromARGB(255, 227, 250, 248),
      body: SafeArea(
        child: Column(
          children: [
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
            //style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
