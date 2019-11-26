import 'dart:convert';

import 'package:github_client_flutter/data/storage/user_storage.dart';

final authInteractorInstance = AuthInteractor();

class AuthInteractor {
  UserStorage storage = userStorage;

  Future<bool> saveToken(String username, String password) async {
    String credentials = "$username:$password";
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String token = stringToBase64.encode(credentials);
    return storage.setToken(token);
  }

  Future<bool> deleteToken() async {
    return storage.setToken(null);
  }

  Future<bool> isLoggedIn() async {
    String token = await storage.getToken();
    return token != null && token != '';
  }
}
