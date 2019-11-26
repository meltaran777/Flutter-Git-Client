import 'package:dio/dio.dart';
import 'package:github_client_flutter/data/model/repository/repository.dart';
import 'package:github_client_flutter/data/model/user/user.dart';
import 'package:github_client_flutter/data/network/git_api_engine.dart';
import 'package:github_client_flutter/data/repository/exception.dart';
import 'package:github_client_flutter/data/source/user_source.dart';

final userRepositoryInstance = UserRepository();

class UserRepository {
  UserSource userSource = apiClient;

  Future<User> getMyUser(bool isCacheEnable) async {
    return userSource.getMyUser().catchError(_handleError);
  }

  Future<List<Repository>> getMyRepositories(
      String type, bool isCacheEnable) async {
    return userSource.getMyRepositories(type).catchError(_handleError);
  }

  _handleError(Object error) {
    switch (error.runtimeType) {
      case DioError:
        final response = (error as DioError).response;
        if (response.statusCode == 401) {
          throw UnauthorizedException("Wrong Login or Password");
        }
        throw FetchException("Request Failed:\n"
            "code = ${response.statusCode};\n"
            "message = ${response.data}");
        break;
      default:
        throw Exception("$error");
    }
  }
}
