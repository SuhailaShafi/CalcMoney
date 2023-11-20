import 'package:evesapp/db/transactiondb.dart';
import 'package:evesapp/models/transactionModel/add_date.dart';
import 'package:evesapp/models/categoryModel/category_model.dart';
import 'package:evesapp/screens/transactions/Pages/All%20Transaction/widget/main_all_list.dart';
import 'package:evesapp/screens/transactions/Pages/All%20Transaction/widget/maintylpeList.dart';
import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class search extends StatefulWidget {
  const search({super.key});

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String searchQuery = ''; // Stores the user's search query
  DateTimeRange? selectedDateRange;
  DateTime? selectedMonth;
  TabController? _tabController;
  List<TransactionModel> _allTransactions = [];
  // ignore: unused_field
  List<TransactionModel> _filteredTransactions = [];
  // Define filter options and the selected filter

  // Default filter is "All"
  String? selectedFilter;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController!.addListener(_handleTabSelection);
    // Initialize _allTransactions with your data from TransactionDB.
    _allTransactions = TransactionDB.instance.transactionListNotifier.value;
    _filteredTransactions = _allTransactions;
  }

  void _handleTabSelection() {
    if (_tabController!.indexIsChanging) {
      setState(() {
        // Filter the transactions based on the selected tab (income or expense).
        if (_tabController!.index == 0) {
          _filteredTransactions = _allTransactions.toList();
        } else if (_tabController!.index == 1) {
          _filteredTransactions = _allTransactions
              .where((transaction) => transaction.type == CategoryType.income)
              .toList();
        } else if (_tabController!.index == 2) {
          _filteredTransactions = _allTransactions
              .where((transaction) => transaction.type == CategoryType.expense)
              .toList();
        }
      });
    }
  } // Function to handle filter selection

  ScrollController ctr = ScrollController();
  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color.fromARGB(255, 227, 250, 248),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Transactions',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [],
        bottom: TabBar(
          labelColor: Colors.white,
          controller: _tabController,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Income'),
            Tab(text: 'Expense'),
          ],
        ),
        // Add more buttons as needed
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MonthFilterMethod(context),
                    const SizedBox(width: 15),
                    DateRangeFilterMethod(context),
                    const SizedBox(width: 15),
                    AllFilterMethod()
                  ],
                )),
            SearchFilterMethod(context),
            const SizedBox(width: 15),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  AllListMethodWidget(
                      context: context,
                      searchQuery: searchQuery,
                      selectedDateRange: selectedDateRange,
                      selectedMonth: selectedMonth),
                  typeListMethodWidget(
                      ctr: ctr,
                      context: context,
                      type: CategoryType.income,
                      searchQuery: searchQuery,
                      selectedDateRange: selectedDateRange,
                      selectedMonth: selectedMonth),
                  typeListMethodWidget(
                      ctr: ctr,
                      context: context,
                      type: CategoryType.expense,
                      searchQuery: searchQuery,
                      selectedDateRange: selectedDateRange,
                      selectedMonth: selectedMonth),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container SearchFilterMethod(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      child: TextField(
        onChanged: (value) {
          // Update the searchQuery when the user types in the TextField
          setState(() {
            searchQuery = value;
          });
        },
        decoration: const InputDecoration(
          hintText: 'Search...',
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    );
  }

  ElevatedButton AllFilterMethod() {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            selectedDateRange = null;
            selectedMonth = null;
          });
        },
        child: const Text('All'));
  }

  ElevatedButton DateRangeFilterMethod(BuildContext context) {
    return ElevatedButton(
      style: const ButtonStyle(
        elevation: MaterialStatePropertyAll(10),
      ),
      onPressed: () async {
        DateTimeRange? pickedDateRange = await showDateRangePicker(
          context: context,
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
          currentDate: selectedDateRange?.start ?? DateTime.now(),
          initialDateRange: selectedDateRange ??
              DateTimeRange(start: DateTime.now(), end: DateTime.now()),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: Colors.teal, // Your primary color
                colorScheme: const ColorScheme.light(primary: Colors.teal),
                buttonTheme:
                    const ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          },
        );
        if (pickedDateRange != null) {
          setState(() {
            selectedDateRange = pickedDateRange;
            selectedMonth =
                null; // Clear the month filter when selecting a date range
          });
        }
      },
      child: const Text(
        'Date range',
      ),
    );
  }

  ElevatedButton MonthFilterMethod(BuildContext context) {
    return ElevatedButton(
      style: const ButtonStyle(elevation: MaterialStatePropertyAll(10)),
      onPressed: () async {
        DateTime? pickedDate = await showMonthPicker(
            context: context,
            initialDate: selectedMonth ?? DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
            selectedMonthBackgroundColor: Colors.teal,
            roundedCornersRadius: 10);
        if (pickedDate != null && pickedDate != selectedMonth) {
          setState(() {
            // Set the selected month to the picked month and year
            selectedMonth = pickedDate;
            selectedDateRange =
                null; // Clear the date range filter when selecting a month
          });
        }
      },
      child: const Text(
        'Select month',
      ),
    );
  }
}
