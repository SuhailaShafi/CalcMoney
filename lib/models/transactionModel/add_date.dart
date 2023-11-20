import 'package:evesapp/models/categoryModel/category_model.dart';
import 'package:hive/hive.dart';
part 'add_date.g.dart';

@HiveType(typeId: 3)
class TransactionModel extends HiveObject {
  @HiveField(0)
  String purpose;
  @HiveField(1)
  double amount;
  @HiveField(2)
  DateTime date;
  @HiveField(3)
  CategoryType type;
  @HiveField(4)
  CategoryModel category;
  @HiveField(5)
  String mode;
  @HiveField(6)
  String id;
  TransactionModel(
      {required this.purpose,
      required this.amount,
      required this.date,
      required this.type,
      required this.category,
      required this.mode,
      required this.id});
}
