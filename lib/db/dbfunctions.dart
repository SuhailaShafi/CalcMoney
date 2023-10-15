import 'package:evesapp/models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

ValueNotifier<List<UserModel>> userdataNotifier = ValueNotifier([]);

Future<void> getUserDetails() async {
  final userDB = await Hive.openBox<UserModel>('user_data');
  userdataNotifier.value.clear();
  userdataNotifier.value.addAll(userDB.values);

  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
  userdataNotifier.notifyListeners();
}
