import 'dart:io';

import 'package:evesapp/models/userModel/usernew_model.dart';
import 'package:evesapp/screens/profile/screen/screen_help/help.dart';
import 'package:evesapp/screens/profile/screen/screen_edit_profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:evesapp/db/userdb.dart';

class UserProfileNotifier extends ValueNotifier<UserNewModel?> {
  UserProfileNotifier(UserNewModel? value) : super(value);
}

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late TextEditingController _nameController;
  String defaultname = 'User';
  late String _selectedAvatrIndex;

  @override
  void initState() {
    UserDb().refreshUI();
    super.initState();
    final userProfile = Hive.box<UserNewModel>('student_data').get(0);
    if (userProfile != null) {
      _nameController = TextEditingController(text: userProfile.name);
      _selectedAvatrIndex = userProfile.images;
      // Use the user's profile data
    } else {
      // Display a default profile or placeholder
      _nameController = TextEditingController(text: "User");
      _selectedAvatrIndex =
          'assets/images/person.jpeg'; // Use a default avatar index
    }
  }

  @override
  Widget build(BuildContext context) {
    UserDb().refreshUI();
    bool isAssetImage = _selectedAvatrIndex.startsWith('assets/');
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Center(
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                'Profile',
                //style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
            ),
          ),
          actions: [
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.info,
                    size: MediaQuery.of(context).size.height * 0.05,
                    color: Colors.white),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return const helpCenter();
                }));
              },
            )
          ]),
      backgroundColor: Colors.teal,
      body: SafeArea(
          child: ValueListenableBuilder<UserNewModel?>(
        valueListenable: UserDb().userdbnotifier,
        builder: (context, userProfile, child) {
          if (userProfile != null) {
            _selectedAvatrIndex = userProfile.images;
            _nameController.text = userProfile.name;
          } else {
            _nameController = TextEditingController(text: "User");
            _selectedAvatrIndex = 'assets/images/person.jpeg';
          }
          return Container(
            width: double.infinity,
            height: 400,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.002),
                  const Align(
                    child: Text(
                      "Profile",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Container(
                      height: 160,
                      width: 160,
                      decoration: BoxDecoration(
                          border: Border.all(
                              style: BorderStyle.solid,
                              width: 10,
                              color: Colors.teal),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: isAssetImage
                                  ? AssetImage(_selectedAvatrIndex)
                                      as ImageProvider
                                  : FileImage(File(_selectedAvatrIndex)),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      _nameController.text,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(height: 35),
                  TextButton(
                      onPressed: () async {
                        await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const EditProfile(),
                        ));
                      },
                      child: const Text(
                        'Edit Profile',
                        style: TextStyle(color: Colors.teal),
                      )),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      )),
    );
  }
}

class KeyboardHider extends StatelessWidget {
  /// Creates a widget that on tap, hides the keyboard.
  const KeyboardHider({
    required this.child,
    Key? key,
  }) : super(key: key);

  /// The widget below this widget in the tree.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: child,
    );
  }
}
