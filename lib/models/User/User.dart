import 'package:hive/hive.dart';

part 'User.g.dart';

@HiveType(typeId: 2)
class User {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String login;
  @HiveField(3)
  final String password;
  @HiveField(4)
  final Map<String, dynamic> warehouse;
  @HiveField(5)
  final Map<String, dynamic> company;

  User(
    this.id,
    this.name,
    this.login,
    this.password,
    this.warehouse,
    this.company,
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'login': login,
      'password': password,
      'warehouse': warehouse,
      'company': company,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['id'] as int,
      json['name'] as String,
      json['login'] as String,
      json['password'] as String,
      json['warehouse'] as Map<String, dynamic>,
      json['company'] as Map<String, dynamic>,
    );
  }
}
