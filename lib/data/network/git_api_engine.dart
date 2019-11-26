import 'package:dio/dio.dart';
import 'package:github_client_flutter/data/model/repository/repository.dart';
import 'package:github_client_flutter/data/model/user/user.dart';
import 'package:github_client_flutter/data/network/git_dio.dart';
import 'package:github_client_flutter/data/source/user_source.dart';
import 'package:retrofit/retrofit.dart';

part 'git_api_engine.g.dart';

GitApiClient _apiClient;

GitApiClient getGitApiClient() {
  if (_apiClient != null) return _apiClient;
  _apiClient = GitApiClient(gitDio.dio);
  return _apiClient;
}

@RestApi(baseUrl: "https://api.github.com")
abstract class GitApiClient implements UserSource {
  factory GitApiClient(Dio dio) = _GitApiClient;

  @GET('/user')
  Future<User> getMyUser();

  @GET('/user/repos')
  Future<List<Repository>> getMyRepositories(@Query('type') String type);
}
