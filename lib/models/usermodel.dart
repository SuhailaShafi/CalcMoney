import 'package:hive/hive.dart';
part 'usermodel.g.dart';

@HiveType(typeId: 1)
class UserModel extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String password;

  @HiveField(4)
  String images;

  UserModel({
    this.id,
    required this.name,
    required this.password,
    required this.images,
  });
}
