import 'package:github_client_flutter/data/model/repository/repository.dart';

abstract class HomeState {}

class InitialState extends HomeState {}

class RepositoriesLoadingState extends HomeState {}

class RepositoriesNotLoadedState extends HomeState {}

class RepositoriesLoadedState extends HomeState {
  final List<Repository> repositories;

  RepositoriesLoadedState(this.repositories);
}

class IsLoggedOutState extends HomeState{}
