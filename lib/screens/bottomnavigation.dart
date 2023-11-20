import 'package:evesapp/screens/category/screen/addcategory.dart';
import 'package:evesapp/screens/category/screen/category.dart';
import 'package:evesapp/screens/piechart/screen/pie_chart.dart';
import 'package:evesapp/screens/profile/screen/screen_view_profile/profileView.dart';
import 'package:evesapp/screens/transactions/Pages/Home/screen/sampleHome.dart';
import 'package:flutter/material.dart';
import 'package:evesapp/screens/transactions/Pages/Add%20Transaction/add_transaction.dart';

class Bottom extends StatefulWidget {
  const Bottom({super.key});

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  // ignore: non_constant_identifier_names
  int index_color = 0;
  // ignore: non_constant_identifier_names
  List Screens = [
    const HomeSample(),
    const PienewChart(),
    const Category(),
    //BarGraph(),
    const ProfileView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screens[index_color],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (index_color == 2) {
            showCategoryAddPopup(context);
          } else {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddScreen()));
          }
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.teal[700],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        height: MediaQuery.of(context).size.height * 0.1,
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.01,
            bottom: MediaQuery.of(context).size.height * 0.01,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 0;
                  });
                },
                child: Icon(
                  Icons.home,
                  size: MediaQuery.of(context).size.height * 0.05,
                  color: index_color == 0 ? Colors.teal[700] : Colors.grey,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 1;
                  });
                },
                child: Icon(
                  Icons.pie_chart,
                  size: MediaQuery.of(context).size.height * 0.05,
                  color: index_color == 1 ? Colors.teal[700] : Colors.grey,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 2;
                  });
                },
                child: Icon(
                  Icons.account_balance_wallet_outlined,
                  size: MediaQuery.of(context).size.height * 0.05,
                  color: index_color == 2 ? Colors.teal[700] : Colors.grey,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    index_color = 3;
                  });
                },
                child: Icon(
                  Icons.person_2_outlined,
                  size: MediaQuery.of(context).size.height * 0.05,
                  color: index_color == 3 ? Colors.teal[700] : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
