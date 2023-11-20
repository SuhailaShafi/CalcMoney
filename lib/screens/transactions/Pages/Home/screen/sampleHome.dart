import 'package:evesapp/models/transactionModel/add_date.dart';
import 'package:evesapp/models/userModel/usernew_model.dart';
import 'package:evesapp/screens/transactions/Pages/All%20Transaction/screen/searchtrans.dart';
import 'package:evesapp/screens/transactions/Pages/Home/widget/balance_stack_home.dart';
import 'package:evesapp/screens/transactions/Pages/Home/widget/user_details_home.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:evesapp/db/transactiondb.dart';
import 'package:evesapp/models/categoryModel/category_model.dart';
import 'package:evesapp/screens/transactions/Pages/Home/widget/trans_List.dart';

class HomeSample extends StatefulWidget {
  const HomeSample({Key? key});

  @override
  State<HomeSample> createState() => _HomeSampleState();
}

class _HomeSampleState extends State<HomeSample> {
  late String _selectedAvatarIndex;
  late String _username;
  double? totalIncome;
  double? totalExpense;
  double? totalBalance;

  List<TransactionModel> _filteredTransactions = [];
  @override
  void initState() {
    super.initState();
    final userProfile = Hive.box<UserNewModel>('student_data').get(0);
    if (userProfile != null) {
      _username = userProfile.name;
      _selectedAvatarIndex = userProfile.images;
      // Use the user's profile data
    } else {
      // Display a default profile or placeholder
      _username = "User";
      _selectedAvatarIndex =
          'assets/images/person.jpeg'; // Use a default avatar index
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 227, 250, 248),
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Center(
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                'CalcMoney',
                //style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: FutureBuilder<void>(
            future: TransactionDB.instance
                .refresh(), // Your asynchronous operation that fetches data
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); // While waiting for data, show a loading indicator
              } else if (snapshot.hasError) {
                return Text(
                    'Error: ${snapshot.error}'); // Display an error message if there's an error
              } else {
                bool isAssetImage = _selectedAvatarIndex.startsWith('assets/');
                return Column(
                  children: [
                    Expanded(
                        flex: 4,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: MediaQuery.of(context).size.width * 1,
                          child: Center(
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      decoration: BoxDecoration(
                                        color: Colors.teal[400],
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                      ),
                                      child: userDetailsWidget(
                                          isAssetImage: isAssetImage,
                                          selectedAvatarIndex:
                                              _selectedAvatarIndex,
                                          username: _username),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top:
                                      MediaQuery.of(context).size.height * 0.12,
                                  left: MediaQuery.of(context).size.width * 0.1,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromRGBO(0, 77, 64, 1),
                                          offset: Offset(
                                            0,
                                            6,
                                          ),
                                          blurRadius: 12,
                                          spreadRadius: 6,
                                        ),
                                      ],
                                      color: Colors.teal[700],
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: CalculateBalanceMethod(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            'Transaction History',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const search(),
                              ));
                            },
                            child: const Text(
                              'See All',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: ValueListenableBuilder<List<TransactionModel>>(
                        valueListenable:
                            TransactionDB.instance.transactionListNotifier,
                        builder: (BuildContext ctx,
                            List<TransactionModel> newList, Widget? _) {
                          _filteredTransactions = newList;
                          if (_filteredTransactions.isNotEmpty) {
                            return TransactionListWidget(
                                filteredTransactions: _filteredTransactions);
                          } else {
                            return const Center(
                                child: Text('No data to display'));
                          }
                        },
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ));
  }

  ValueListenableBuilder<List<TransactionModel>> CalculateBalanceMethod() {
    return ValueListenableBuilder<List<TransactionModel>>(
        valueListenable: TransactionDB.instance.transactionListNotifier,
        builder:
            (BuildContext context, List<TransactionModel> newList, Widget? _) {
          final transactions = newList;
          final now = DateTime.now();
          totalIncome = transactions
              .where((transaction) =>
                  transaction.type == CategoryType.income &&
                  transaction.date.year == now.year &&
                  transaction.date.month == now.month)
              .fold(0.0, (sum, transaction) => sum! + transaction.amount);
          totalExpense = transactions
              .where((transaction) =>
                  transaction.type == CategoryType.expense &&
                  transaction.date.year == now.year &&
                  transaction.date.month == now.month)
              .fold(0.0, (sum, transaction) => sum! + transaction.amount);
          totalBalance = (totalIncome ?? 0) - (totalExpense ?? 0);

          return balanceStackWidget(
              totalBalance: totalBalance,
              totalIncome: totalIncome,
              totalExpense: totalExpense);
        });
  }
}
