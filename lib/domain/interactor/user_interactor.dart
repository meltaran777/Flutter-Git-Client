import 'package:github_client_flutter/data/model/repository/repository.dart';
import 'package:github_client_flutter/data/model/user/user.dart';
import 'package:github_client_flutter/data/repository/user_repository.dart';

final userIntaractorInstance = UserInteractor();

class UserInteractor {
  UserRepository userRepository = userRepositoryInstance;

  Future<User> getMyUser() {
    return userRepository.getMyUser(false);
  }

  Future<List<Repository>> getMyRepositories() {
    return userRepository.getMyRepositories("all", false);
  }
}
