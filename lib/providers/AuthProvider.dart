import 'package:flutter/material.dart';
import 'package:venons_automark/models/User/User.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuth = false;
  bool _isLoad = false;
  late User user;

  Future<void> getUserFromDb() async {}
  Future<void> login(String name, String password) async {
    try {
      _isAuth = true;
      notifyListeners();
    } catch (e) {
      print(e);
      _isAuth = false;
      _isLoad = false;
    }
  }

  bool get isAuth => _isAuth;
  bool get isLoad => _isLoad;
}
