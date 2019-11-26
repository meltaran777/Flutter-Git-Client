import 'package:github_client_flutter/data/model/repository/repository.dart';
import 'package:github_client_flutter/data/model/user/user.dart';

abstract class UserSource {
  Future<User> getMyUser();

  Future<List<Repository>> getMyRepositories(String type);
}
