import 'package:dio/dio.dart';
import 'package:github_client_flutter/data/storage/user_storage.dart';
import 'package:github_client_flutter/util/logger.dart';

final gitDio = GitDio();

class GitDio {
  UserStorage storage = userStorage;
  Dio dio;

  GitDio() {
    this.dio = Dio();
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (obj) {
        Logger.logPrint(obj);
      },
    ));
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) => _authInterceptor(options),
    ));
  }

  dynamic _authInterceptor(RequestOptions options) async {
    final token = await storage.getToken();
    options.headers.addAll({"Authorization": "Basic $token"});
    return options;
  }
}
