import 'package:hive/hive.dart';
part 'usermodel.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  UserModel({
    required this.username,
    required this.email,
    required this.phnum,
    required this.dob,
    required this.city,
    required this.country,
    required this.password,
    required this.gender,
  });
  @HiveField(0)
  String username;
  @HiveField(1)
  String email;
  @HiveField(2)
  String phnum;
  @HiveField(3)
  DateTime dob;
  @HiveField(4)
  String city;
  @HiveField(5)
  String country;
  @HiveField(6)
  String password;
  @HiveField(7)
  String gender;
}

