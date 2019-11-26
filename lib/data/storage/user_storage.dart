import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

final userStorage = UserStorage();

class UserStorage {
  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  Future<String> getToken() async {
    final p = await _prefs;
    return p.getString('token') ?? '';
  }

  Future<bool> setToken(String token) async {
    final p = await _prefs;
    return p.setString('token', token);
  }
}
