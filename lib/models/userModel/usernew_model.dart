import 'package:hive/hive.dart';
part 'usernew_model.g.dart';

@HiveType(typeId: 6)
class UserNewModel extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  String images;

  UserNewModel({
    required this.name,
    required this.images,
  });
}
