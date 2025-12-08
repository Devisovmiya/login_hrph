import 'package:hive/hive.dart';
part 'usermodel.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  UserModel({
    required this.username,
    required this.email,
    required this.password,
    required this.gender,
  });
  @HiveField(0)
  String username;
  @HiveField(1)
  String email;
  @HiveField(2)
  String password;
  @HiveField(3)
  String gender;

  
}
