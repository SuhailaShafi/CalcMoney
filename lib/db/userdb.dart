import 'package:evesapp/models/userModel/usernew_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class UserDbFunctions {
  Future<UserNewModel> getuser();
}

class UserDb implements UserDbFunctions {
  UserDb.internal() {
    // _initializeDefaultCategories();
  }

  static UserDb instance = UserDb.internal();

  factory UserDb() {
    return UserDb.instance;
  }

  ValueNotifier<UserNewModel?> userdbnotifier = ValueNotifier(null);
  @override
  Future<UserNewModel> getuser() async {
    final usernewProfileBox = Hive.box<UserNewModel>('student_data');
    UserNewModel userProfile = usernewProfileBox.get(0)!;
    return userProfile;
  }

  Future<void> refreshUI() async {
    userdbnotifier.value = await getuser();
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    userdbnotifier.notifyListeners();
  }
}
