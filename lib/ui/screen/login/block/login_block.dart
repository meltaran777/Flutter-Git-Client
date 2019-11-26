import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:github_client_flutter/data/model/user/user.dart';
import 'package:github_client_flutter/data/repository/exception.dart';
import 'package:github_client_flutter/domain/interactor/auth_interactor.dart';
import 'package:github_client_flutter/domain/interactor/user_interactor.dart';
import 'package:github_client_flutter/ui/screen/login/validator/login_validator.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> with LoginValidator {
  UserInteractor userInteractor = userIntaractorInstance;
  AuthInteractor authInteractor = authInteractorInstance;

  final _usernamelController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Function(String) get changeUsername => _usernamelController.sink.add;

  Stream<String> get email => _usernamelController.stream.transform(validateUsername);

  Function(String) get changePassword => _passwordController.sink.add;

  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);

  @override
  LoginState get initialState {
    return IsNotLoggedInState();
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginPressedEvent) {
      yield LoginInProgressState();

      final validUsername = _usernamelController.value;
      final validPassword = _passwordController.value;
      final isTokenSaved = await authInteractor.saveToken(validUsername, validPassword);
      print("Email = $validUsername; Password = $validPassword");

      User user;
      try {
        user = await userInteractor.getMyUser();
      } on UnauthorizedException catch (_) {
        yield UnauthorizedState();
      } catch (e) {
        print("Error: $e");
      }

      if (isTokenSaved && user != null)
        yield IsLoggedInState();
      else {
        await authInteractor.deleteToken();
        yield IsNotLoggedInState();
      }
    }
  }

  dispose() {
    _usernamelController.close();
    _passwordController.close();
  }
}

//event
abstract class LoginEvent {}

class LoginPressedEvent extends LoginEvent {}

//state
abstract class LoginState {}

class LoginInProgressState extends LoginState {}

class IsLoggedInState extends LoginState {}

class IsNotLoggedInState extends LoginState {}

class UnauthorizedState extends LoginState {}
