import 'package:evesapp/models/transactionModel/add_date.dart';
import 'package:evesapp/models/categoryModel/category_model.dart';
import 'package:evesapp/models/userModel/usernew_model.dart';
import 'package:evesapp/screens/Splash/splash.dart';
import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

const SAVE_KEY_NAME = 'UserLoggedIn';
void main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();

  Hive.registerAdapter(CategoryTypeAdapter());
  Hive.registerAdapter(CategoryModelAdapter());
  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }

  if (!Hive.isAdapterRegistered(UserNewModelAdapter().typeId)) {
    Hive.registerAdapter(UserNewModelAdapter());
  }

  // ignore: unused_local_variable
  var usernewBox = await Hive.openBox<UserNewModel>('student_data');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CalcMoney',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const ScreenSplash(),
      debugShowCheckedModeBanner: false,
    );
  }
}
