import 'package:evesapp/screens/category/addcategory.dart';
import 'package:evesapp/screens/category/category.dart';
import 'package:evesapp/screens/piechart/piechart.dart';
import 'package:evesapp/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:evesapp/screens/transactions/add.dart';
import 'package:evesapp/screens/transactions/home.dart';

class Bottom extends StatefulWidget {
  const Bottom({super.key});

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  int index_color = 0;
  List Screens = [home(), pichart(), Category(), Profile()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screens[index_color],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (index_color == 2) {
            showCategoryAddPopup(context);
          } else {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return Add_screen();
            }));
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.teal[700],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.only(top: 7.5, bottom: 7.5),
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
                  size: 30,
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
                  Icons.bar_chart_outlined,
                  size: 30,
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
                  size: 30,
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
                  size: 30,
                  color: index_color == 3 ? Colors.teal[700] : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}
