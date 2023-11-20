import 'dart:io';
import 'package:evesapp/db/userdb.dart';
import 'package:evesapp/models/userModel/usernew_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

XFile? images;

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late TextEditingController _nameController;
  late String _selectedAvatrIndex;
  late UserNewModel? userProfile;
  ValueNotifier<UserNewModel?> userPNotifier =
      ValueNotifier<UserNewModel?>(null);
  // ignore: non_constant_identifier_names
  final _FormKey = GlobalKey<FormState>();
  XFile? eves;
  @override
  void initState() {
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
    bool isAssetImage = _selectedAvatrIndex.startsWith('assets/');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        actions: [
          TextButton(
              onPressed: () async {
                if (_FormKey.currentState!.validate()) {
                  await onAddStudententButtonClicked(context);
                  images = null;
                  setState(() {
                    eves = null;
                  });
                }
              },
              child: const Text(
                'Done',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      backgroundColor: Colors.teal,
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        width: double.infinity,
        height: 400,
        child: ListView(
          children: [
            const SizedBox(
              height: 30,
            ),
            const Align(
              child: Text("Edit Profile",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _FormKey,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // images = null;
                      },
                      child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.transparent,
                          child: ClipRRect(
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: isAssetImage
                                      ? AssetImage(_selectedAvatrIndex)
                                          as ImageProvider
                                      : FileImage(File(_selectedAvatrIndex)),
                                  //image: AssetImage('assets/images/img.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        images = uploadImage(context);
                      },
                      child: const Text(
                        'Edit',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your  full name';
                        } else {
                          return null;
                        }
                      },
                      controller: _nameController,
                      decoration: InputDecoration(
                        // labelText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 71, 66, 66)),
                        fillColor: Colors.white70,
                        hintText: 'Student name',
                      ),
                    ),
                    const SizedBox(height: 20),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onAddStudententButtonClicked(context) async {
    final _name = _nameController.text.trim();

    if (_name.isEmpty) {
      return;
      // ignore: unnecessary_null_comparison
    } else if (_selectedAvatrIndex == null) {
      imageError();
    } else {
      _FormKey.currentState!.reset;

      final _student = UserNewModel(name: _name, images: _selectedAvatrIndex);
      userPNotifier.value = _student;
      _updateUserProflie(_student);
      //addStudent(_student);
      //images = null;
      showDialog(
        context: context,
        builder: (context) {
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.of(context).pop(true);
          });
          return const AlertDialog(
            backgroundColor: Colors.white,
            actions: [
              SizedBox(
                height: 30,
              ),
              Align(
                child: Text(
                  'Updated',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 12, 92, 15)),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          );
        },
      );

      Navigator.pop(context, _student);
    }
  }

  uploadImage(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: 200,
        width: double.infinity,
        child: Column(
          children: [
            ListTile(
              onTap: () async {
                Navigator.pop(context);
                _showAvatarSelectionBottomSheet();
              },
              leading: IconButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    _showAvatarSelectionBottomSheet();
                  },
                  icon: const Icon(Icons.person)),
              title: const Text('Avatar'),
            ),
            ListTile(
              onTap: () async {
                Navigator.pop(context);
                images = await pickImage(ImageSource.camera);
              },
              leading: IconButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    images = await pickImage(ImageSource.camera);
                  },
                  icon: const Icon(Icons.camera_enhance)),
              title: const Text('Camera'),
            ),
            ListTile(
              onTap: () async {
                Navigator.pop(context);
                images = await pickImage(ImageSource.gallery);
              },
              leading: IconButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    images = await pickImage(ImageSource.gallery);
                  },
                  icon: const Icon(Icons.photo)),
              title: const Text('Gallery'),
            ),
          ],
        ),
      ),
    );
  }

  imageError() {
    const snakbar = SnackBar(
      content: Text('Upload image and continue'),
      margin: EdgeInsets.all(30),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snakbar);
  }

  Future<XFile?> pickImage(ImageSource imageSource) async {
    final image = await ImagePicker().pickImage(source: imageSource);
    setState(() {
      eves = image;
      _selectedAvatrIndex = image?.path ?? _selectedAvatrIndex;
    });
    return image;
  }

  void textFeildClear() {
    _nameController.clear();
  }

  void _updateUserProflie(UserNewModel stud) async {
    final usernewProfileBox = Hive.box<UserNewModel>('student_data');
    usernewProfileBox.put(0, stud);
    UserDb().refreshUI();
    setState(() {
      userProfile = usernewProfileBox.get(0)!;
    });

    //Navigator.of(context).pop(); // close the bottom sheet
    Navigator.pop(context);
  }

  _showAvatarSelectionBottomSheet() {
    return showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: const Icon(Icons.arrow_back),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const Center(
                    child: Text(
                      'Select Avatar',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedAvatrIndex = 'assets/images/avatar1.png';
                      });
                      Navigator.of(context).pop();
                    },
                    child: const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/avatar1.png'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedAvatrIndex = 'assets/images/avatar2.png';
                      });
                      Navigator.of(context).pop();
                    },
                    child: const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/avatar2.png'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedAvatrIndex = 'assets/images/avatar3.png';
                      });
                      Navigator.of(context).pop();
                    },
                    child: const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/avatar3.png'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedAvatrIndex = 'assets/images/avatar4.png';
                      });
                      Navigator.of(context).pop();
                    },
                    child: const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/avatar4.png'),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedAvatrIndex = 'assets/images/avatar5.png';
                      });
                      Navigator.of(context).pop();
                    },
                    child: const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/avatar5.png'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedAvatrIndex = 'assets/images/avatar6.png';
                      });
                      Navigator.of(context).pop();
                    },
                    child: const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/avatar6.png'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedAvatrIndex = 'assets/images/avatar7.png';
                      });
                      Navigator.of(context).pop();
                    },
                    child: const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/avatar7.png'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedAvatrIndex = 'assets/images/avatar8.png';
                      });
                      Navigator.of(context).pop();
                    },
                    child: const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/avatar8.png'),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedAvatrIndex = 'assets/images/avatar9.png';
                      });
                    },
                    child: const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/avatar9.png'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedAvatrIndex = 'assets/images/avatar10.png';
                      });
                    },
                    child: const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/avatar10.png'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedAvatrIndex = 'assets/images/avatar11.png';
                      });
                      Navigator.of(context).pop();
                    },
                    child: const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/avatar11.png'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedAvatrIndex = 'assets/images/avatar12.png';
                      });
                      Navigator.of(context).pop();
                    },
                    child: const CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/avatar12.png'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
