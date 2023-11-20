import 'package:evesapp/db/categorydb.dart';
import 'package:evesapp/models/transactionModel/add_date.dart';
import 'package:evesapp/models/categoryModel/category_model.dart';
import 'package:evesapp/screens/transactions/Pages/Edit%20Transaction/widgets/amount.dart';
import 'package:evesapp/screens/transactions/Pages/Edit%20Transaction/widgets/background.dart';
import 'package:evesapp/screens/transactions/Pages/Edit%20Transaction/widgets/heading.dart';
import 'package:evesapp/screens/transactions/Pages/Edit%20Transaction/widgets/save.dart';
import 'package:flutter/material.dart';

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

class EditScreen extends StatefulWidget {
  final TransactionModel transaction;
  const EditScreen({required this.transaction});
  @override
  State<EditScreen> createState() => EditScreenState(transaction: transaction);
}

class EditScreenState extends State<EditScreen> {
  final TransactionModel transaction;
  EditScreenState({required this.transaction});
  CategoryType? _selectedCategoryType;
  CategoryModel? _selectedCategoryModel;

  String? _categoryID;

  DateTime date = DateTime.now();
  String? selectedItem;
  String? selectedMode;
  bool validate = false;
  bool _validate = false;
  TextEditingController? headingC;
  FocusNode hd = FocusNode();

  TextEditingController? amountC;
  FocusNode am = FocusNode();

  final List<String> mode = ['Account', 'Cash'];
  String? errortxt;
  String? validateDropdown(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a category';
    }
    return null; // Return null when the value is valid
  }

  @override
  void initState() {
    _selectedCategoryType = transaction.type;
    _selectedCategoryModel = transaction.category;
    _categoryID = transaction.category.id;
    date = transaction.date;
    selectedMode = transaction.mode;
    amountC = TextEditingController(text: transaction.amount.toString());
    headingC = TextEditingController(text: transaction.purpose);

    super.initState();
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
              Column(
                children: [BackgroundContainerWidget()],
              ),
              Positioned(
                top: 120,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  height: MediaQuery.of(context).size.height * 0.9,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      CategoryTypesMethod(),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      CategoryMethod(context),
                      if (errortxt != null)
                        Text(
                          errortxt!,
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      ModeMethod(),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      HeadingWidget(
                          hd: hd, headingC: headingC, validate: validate),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      AmountWidget(
                          am: am, amountC: amountC, validate: _validate),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      DateMethod(context),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      SaveWidget(
                          headingC: headingC,
                          amountC: amountC,
                          categoryID: _categoryID,
                          transaction: transaction,
                          date: date,
                          selectedCategoryType: _selectedCategoryType,
                          selectedCategoryModel: _selectedCategoryModel,
                          selectedMode: selectedMode),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row CategoryTypesMethod() {
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

  Padding CategoryMethod(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            width: MediaQuery.of(context).size.width * 0.7,
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

  Padding DateMethod(BuildContext context) {
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

  Padding ModeMethod() {
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
}
