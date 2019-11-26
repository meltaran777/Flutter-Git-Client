import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent {}

class LoadRepositoriesEvent extends HomeEvent {}

class LogoutEvent extends HomeEvent {}

class InitEvent extends HomeEvent {}
