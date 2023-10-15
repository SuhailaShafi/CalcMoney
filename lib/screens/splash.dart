import 'package:evesapp/db/dbfunctions.dart';
import 'package:evesapp/screens/bottomnavigation.dart';

import 'package:flutter/material.dart';
import 'package:evesapp/main.dart';
import 'package:evesapp/screens/transactions/home.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset(
          'assets/images/money_symbol.jpg',
          height: 150,
          width: 150,
        ),
        SizedBox(
          height: 60,
        ),
        const Text('Calc Money',
            style: TextStyle(
              color: Colors.teal,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            )),
        SizedBox(
          height: 30,
        ),
        const Text('Welcome to Calc Money',
            style: TextStyle(
                color: Color.fromARGB(255, 12, 12, 12),
                fontSize: 25,
                fontStyle: FontStyle.italic)),
        Container(
          padding: EdgeInsets.all(20),
          alignment: Alignment.center,
          child: const Text(
              'Calc Money is an app for simple income and expense tracking',
              style: TextStyle(
                  color: Color.fromARGB(255, 4, 4, 4),
                  fontSize: 15,
                  fontStyle: FontStyle.italic)),
        )
      ]),
    )); // TODO: implement build
    throw UnimplementedError();
  }

  @override
  void initState() {
    CheckUserLoggedIn();

    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> gotoLogin() async {
    await Future.delayed(Duration(seconds: 5));
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
      return Bottom();
    }));
  }

  Future<void> CheckUserLoggedIn() async {
    getUserDetails();
    final sharedpref = await SharedPreferences.getInstance();
    final _userloggedIn = sharedpref.getBool(SAVE_KEY_NAME);
    if (_userloggedIn == null || _userloggedIn == false) {
      gotoLogin();
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => home()));
    }
  }
}
