import 'package:evesapp/db/categorydb.dart';
import 'package:evesapp/db/transactiondb.dart';
import 'package:evesapp/models/transactionModel/add_date.dart';
import 'package:evesapp/models/categoryModel/category_model.dart';
import 'package:evesapp/screens/transactions/Pages/Add%20Transaction/widgets/AmountAdd.dart';
import 'package:evesapp/screens/transactions/Pages/Add%20Transaction/widgets/HeadingAdd.dart';
import 'package:evesapp/screens/transactions/Pages/Add%20Transaction/widgets/backgroundAdd.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks, unused_field, no_leading_underscores_for_local_identifiers

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
// Initialize with a default value

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  State<AddScreen> createState() => AddScreenState();
}

// A callback function type to update the selected category type and ID
// typedef CategoryCallback = void Function(CategoryType categoryType, String categoryId);

class AddScreenState extends State<AddScreen> {
  CategoryType? _selectedCategoryType;
  CategoryModel? _selectedCategoryModel;
  String? errortxt;
  String? _categoryID;

  DateTime date = DateTime.now();
  String? selectedItem;

  String? selectedMode = 'Account';
  String? selectedAccount = '123445';
  bool validate = false;

  final TextEditingController headingC = TextEditingController();
  FocusNode hd = FocusNode();

  final TextEditingController amountC = TextEditingController();
  FocusNode am = FocusNode();

  final List<String> mode = ['Account', 'Cash'];
  bool _validate = false;
  String? validateDropdown(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a category';
    }
    return null; // Return null when the value is valid
  }

  @override
  void initState() {
    _selectedCategoryType = CategoryType.income;
    super.initState();

    hd.addListener(() {
      setState(() {});
    });
    am.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              BackgroundAddWidget(),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.1,
                child: mainContainer(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container mainContainer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      height: MediaQuery.of(context).size.height * 0.9,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          typeRadioButton(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          category(),
          if (errortxt != null)
            Text(
              errortxt!,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          trasactionMode(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          HeadingAddWidget(hd: hd, headingC: headingC, validate: _validate),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          AmountAddWidget(am: am, amountC: amountC, validate: _validate),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          dateTime(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03)
        ],
      ),
    );
  }

  Padding trasactionMode() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: Colors.grey,
          ),
        ),
        child: DropdownButton<String>(
          value: selectedMode,
          onChanged: ((value) {
            setState(() {
              selectedMode = value!;
            });
          }),
          items: mode
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e, style: TextStyle(fontSize: 18)),
                  ))
              .toList(),
          selectedItemBuilder: (BuildContext context) => mode
              .map((e) => Row(
                    children: [Text(e, style: TextStyle(fontSize: 18))],
                  ))
              .toList(),
          dropdownColor: Colors.white,
          isExpanded: true,
          underline: Container(),
        ),
      ),
    );
  }

  GestureDetector saveButton() {
    return GestureDetector(
      onTap: () {
        addTransaction();
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

  Padding dateTime() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19),
      child: Container(
        alignment: Alignment.bottomLeft,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2, color: Colors.grey)),
        child: TextButton(
          onPressed: () async {
            DateTime? newDate = await showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime.now().subtract(const Duration(days: 60)),
              lastDate: DateTime.now(),
            );
            if (newDate == Null) {
              return;
            }

            setState(() {
              date = newDate!;
            });
          },
          child: Text(
            'Date : ${date.day} / ${date.month} / ${date.year}',
            style: TextStyle(fontSize: 15, color: Colors.blue),
          ),
        ),
      ),
    );
  }

  Padding category() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                width: 2,
                color: Colors.grey,
              ),
            ),
            child: DropdownButton<String>(
              alignment: AlignmentDirectional.centerStart,
              value: _categoryID,
              items: ([
                if (_selectedCategoryType == CategoryType.income)
                  ...defaultCategories
                else
                  ...defaultExpenseCategory, // Show default items only for income type
                ...(_selectedCategoryType == CategoryType.income
                        ? CategoryDb().incomeCategoryListListner
                        : CategoryDb().expenseCategoryListListner)
                    .value
              ]).toSet().map((e) {
                return DropdownMenuItem(
                  value: e.id,
                  child: Text(e.name),
                  onTap: () {
                    setState(() {
                      _selectedCategoryModel = e;
                    });
                  },
                );
              }).toList(),
              onChanged: (selectedValue) {
                setState(() {
                  _categoryID = selectedValue;
                  errortxt = validateDropdown(selectedValue);
                });
              },
              hint: Text(
                'Category',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              dropdownColor: Colors.white,
              isExpanded: true,
              underline: Container(),
            ),
          ),
        ],
      ),
    );
  }

  Widget typeRadioButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            Radio(
              value: CategoryType.expense,
              groupValue: _selectedCategoryType,
              onChanged: (newValue) {
                setState(() {
                  _selectedCategoryType = CategoryType.expense;
                  _categoryID = null;
                });
              },
            ),
            const Text(
              'Expense',
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
        Row(
          children: [
            Radio(
              value: CategoryType.income,
              groupValue: _selectedCategoryType,
              onChanged: (newValue) {
                setState(() {
                  _selectedCategoryType = CategoryType.income;
                  _categoryID = null;
                });
              },
            ),
            const Text(
              'Income',
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
        SizedBox(
          width: 15,
        )
      ],
    );
  }

  Future<void> addTransaction() async {
    final _purposetxt = headingC.text;
    final _amountText = amountC.text;

    if (_purposetxt.isEmpty) {
      setState(() {
        _validate = _purposetxt.isEmpty;
      });
      return;
    }
    if (_amountText.isEmpty) {
      return;
    }
    if (_categoryID == null) {
      setState(() {
        errortxt = 'please select a category';
      });

      return;
    }
    final parsedamount = double.tryParse(_amountText);
    if (parsedamount == null) {
      validate = parsedamount.toString().isEmpty;
      return;
    }
    if (_selectedCategoryModel == null) {
      return;
    }
    final addid = DateTime.now().toString();
    // ignore: unnecessary_null_comparison
    if (addid == null) {
      return;
    }
    final _model = TransactionModel(
      purpose: _purposetxt,
      amount: parsedamount,
      date: date,
      type: _selectedCategoryType!,
      category: _selectedCategoryModel!,
      mode: selectedMode!,
      id: addid,
    );
    await TransactionDB.instance.addTransaction(_model);
    print('transactionid $addid');
    Navigator.of(context).pop();
  }
}
