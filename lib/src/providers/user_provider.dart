// user_provider.dart

import 'package:flutter/material.dart';
import 'package:urban_app/src/models/user_data.dart';

class UserProvider extends ChangeNotifier {
  UserData? _loggedInUser;

  UserData? get loggedInUser => _loggedInUser;

  set loggedInUser(UserData? user) {
    _loggedInUser = user;
    notifyListeners();
  }
}
