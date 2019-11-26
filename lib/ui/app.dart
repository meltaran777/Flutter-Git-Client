import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_client_flutter/domain/interactor/auth_interactor.dart';
import 'package:github_client_flutter/ui/screen/home/bloc/home_bloc.dart';
import 'package:github_client_flutter/ui/screen/home/home_screen.dart';
import 'package:github_client_flutter/ui/screen/login/block/login_block_provider.dart';
import 'package:github_client_flutter/ui/screen/login/login_screen.dart';

class App extends StatefulWidget {
  @override
  State createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  AuthInteractor authInteractor = authInteractorInstance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoginBlockProvider(
      child: BlocProvider(
        builder: (context) => HomeBloc(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) {
            return FutureBuilder<bool>(
                future: authInteractor.isLoggedIn(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    bool isLogged = snapshot.data;
                    return isLogged ? HomeScreen() : LoginScreen();
                  }
                  return Scaffold(
                    body: Text('Splash Screen'),
                  );
                });
          },
        );
        break;
      case 'login':
        return MaterialPageRoute(
          builder: (context) {
            return LoginScreen();
          },
        );
        break;
      case 'home':
        return MaterialPageRoute(
          builder: (context) {
            return HomeScreen();
          },
        );
        break;
      default:
        throw Exception('Screen ${settings.name} doesn`t exist');
    }
  }
}
