import 'package:evesapp/models/add_date.dart';
import 'package:evesapp/models/category_model.dart';

import 'package:evesapp/screens/splash.dart';
import 'package:evesapp/screens/transactions/add.dart';
import 'package:flutter/material.dart';
import 'package:evesapp/screens/bottomnavigation.dart';
import 'package:evesapp/screens/transactions/home.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

const SAVE_KEY_NAME = 'UserLoggedIn';
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(AddDataAdapter());
  Hive.registerAdapter(CategoryTypeAdapter());
  Hive.registerAdapter(CategoryModelAdapter());

  await Hive.openBox<AddData>('data');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calc Money',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const ScreenSplash(),
      debugShowCheckedModeBanner: false,
    );
  }
}
