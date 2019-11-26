import 'package:github_client_flutter/data/model/repository/repository.dart';

abstract class HomeState {}

class InitialState extends HomeState {}

class RepositoriesLoading extends HomeState {}

class RepositoriesNotLoaded extends HomeState {}

class RepositoriesLoaded extends HomeState {
  final List<Repository> repositories;

  RepositoriesLoaded(this.repositories);
}

class IsLoggedOut extends HomeState{}
