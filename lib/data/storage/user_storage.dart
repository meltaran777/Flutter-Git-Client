import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

final userStorage = UserStorage();

class UserStorage {
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  Future<String> getToken() async {
    final p = await prefs;
    return p.getString('token') ?? '';
  }

  Future<bool> setToken(String token) async {
    final p = await prefs;
    return p.setString('token', token);
  }
}
