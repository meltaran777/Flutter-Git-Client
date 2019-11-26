import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'block/login_block.dart';

class LoginScreen extends StatefulWidget {
  @override
  State createState() {
    return _LoginState();
  }
}

class _LoginState extends State<LoginScreen> {
  LoginBloc _loginBloc;

  @override
  void initState() {
    _loginBloc = LoginBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        margin: EdgeInsets.only(
          left: 8.0,
          right: 8.0,
        ),
        child: Column(
          children: <Widget>[
            emailWidget(_loginBloc),
            spaceWidget(8.0),
            passwordWidget(_loginBloc),
            spaceWidget(8.0),
            submitButtonWidget(_loginBloc),
          ],
        ),
      ),
    );
  }

  Widget spaceWidget(double spaceSize) {
    return Container(
      margin: EdgeInsets.only(top: spaceSize),
    );
  }

  Widget emailWidget(LoginBloc loginBloc) {
    return StreamBuilder(
      stream: loginBloc.email,
      builder: (context, snapshot) {
        return TextField(
          onChanged: loginBloc.changeUsername,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: "username",
            labelText: "Username",
            errorText: snapshot.error,
          ),
        );
      },
    );
  }

  Widget passwordWidget(LoginBloc loginBloc) {
    return StreamBuilder(
      stream: loginBloc.password,
      builder: (context, snapshot) {
        return TextField(
          obscureText: true,
          onChanged: loginBloc.changePassword,
          decoration: InputDecoration(
            hintText: "Password",
            labelText: "Enter password",
            errorText: snapshot.error,
          ),
        );
      },
    );
  }

  Widget submitButtonWidget(LoginBloc loginBloc) {
    return BlocBuilder(
      bloc: loginBloc,
      builder: (context, state) {
        if (state is LoginInProgressState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is IsLoggedInState) {
          _post(() => Navigator.pushReplacementNamed(context, 'home'));
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (state is UnauthorizedState) {
            _post(() {
              _showAlertDialog(context, 'Wrong Cerdentials!',
                  'Invalid Username or Password');
            });
          }
          return RaisedButton(
            textColor: Colors.white,
            color: Colors.blue,
            child: Text("Submit"),
            onPressed: () {
              loginBloc.add(LoginPressedEvent());
            },
          );
        }
      },
    );
  }

  _showAlertDialog(BuildContext context, String title, String message) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("$title"),
      content: Text("$message"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _post(Function action) {
    WidgetsBinding.instance.addPostFrameCallback((_) => action());
  }
}
