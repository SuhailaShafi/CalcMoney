import 'package:evesapp/screens/bottomnavigation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({Key? key}) : super(key: key);

  @override
  _GetStartedPageState createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  late SharedPreferences _prefs;
  bool _hasSeenGetStarted = false;

  @override
  void initState() {
    super.initState();
    _loadSharedPreferences();
  }

  Future<void> _loadSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _hasSeenGetStarted = _prefs.getBool('hasSeenGetStarted') ?? false;
    });
  }

  Future<void> _markAsSeen() async {
    await _prefs.setBool('hasSeenGetStarted', true);
    setState(() {
      _hasSeenGetStarted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasSeenGetStarted) {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 177, 236, 222),
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Center(child: Text('CalcMoney')),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  'Welcome to CalcMoney',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 25),
              const Center(
                child: Text(
                  'Calc Money is an app for simple ',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                ),
              ),
              const Center(
                child: Text(
                  ' income and expense tracking',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(height: 25),
              Container(
                width: 200,
                height: 200,
                child: Image.asset('assets/images/scrn_profile.png'),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'To know more about CalcMoney, ',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
                ),
              ),
              const Center(
                child: Text(
                  'Tap on the Info icon in Profile ',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _markAsSeen();
                  // Navigate to your main app content after marking as seen
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Bottom()));
                },
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.teal,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return const Bottom(); // Placeholder, replace with your main app content
    }
  }
}
