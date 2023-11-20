import 'package:evesapp/screens/Splash/get_started.dart';

import 'package:flutter/material.dart';

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
          'assets/images/ic_launcher.png',
          height: 150,
          width: 150,
        ),
        const SizedBox(
          height: 60,
        ),
        const Text('Welcome to Calc Money',
            style: TextStyle(
                color: Colors.teal, fontSize: 25, fontStyle: FontStyle.italic)),
        Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          child: const Text('',
              style: TextStyle(
                  color: Color.fromARGB(255, 4, 4, 4),
                  fontSize: 15,
                  fontStyle: FontStyle.italic)),
        )
      ]),
    )); // TODO: implement build
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
    await Future.delayed(const Duration(seconds: 5));
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
      return const GetStartedPage();
    }));
  }

  Future<void> CheckUserLoggedIn() async {
    gotoLogin();
  }
}
