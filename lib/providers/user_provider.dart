import '../models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get getUserModel => _user;

  void setUserModel(User user) {
    _user = user;
    notifyListeners();
  }
}
