import 'package:flutter/cupertino.dart';

import 'login_block.dart';

class LoginBlockProvider extends InheritedWidget {
  final loginBloc = LoginBloc();

  LoginBlockProvider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static LoginBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(LoginBlockProvider)
    as LoginBlockProvider)
        .loginBloc;
  }
}
