import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_client_flutter/data/model/repository/repository.dart';
import 'package:github_client_flutter/ui/screen/home/bloc/home_event.dart';
import 'package:github_client_flutter/ui/screen/home/bloc/home_state.dart';
import 'package:provider/provider.dart';
import 'bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  State createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomeScreen> {
  HomeBloc _homeBloc;

  @override
  void initState() {
    _homeBloc = HomeBloc();
    _homeBloc.add(LoadRepositoriesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GitHub"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            tooltip: 'Log out',
            onPressed: () {
              _homeBloc.add(LogoutEvent());
            },
          )
        ],
      ),
      body: BlocBuilder(
          bloc: _homeBloc,
          builder: (context, state) {
            if (state is IsLoggedOut) {
              _openHome();
              _homeBloc.add(InitEvent());
              return Container();
            }

            if (state is InitialState) {
              return Container();
            }

            if (state is RepositoriesLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is RepositoriesLoaded) {
              final repos = state.repositories;
              return _repositoriesList(repos);
            }

            if (state is RepositoriesNotLoaded) {
              return Text("Repositories Not Loaded");
            }

            return Container(
              child: Text('Unhandled state $state'),
            );
          }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _homeBloc.dispose();
  }

  Widget _repositoriesList(List<Repository> repos) {
    return ListView.builder(
      itemCount: repos.length,
      itemBuilder: (context, index) {
        final item = repos[index];
        return _repositoryListItem(item);
      },
    );
  }

  Widget _repositoryListItem(Repository item) {
    return Material(
      child: InkWell(
        onTap: () => print('repo click'),
        child: Column(
          children: <Widget>[
            ListTile(
                title: Text(item.name),
                subtitle: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        item.getDescriptionText(),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Text('${item.stargazersCount}'),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                      ],
                    )
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete_forever),
                  onPressed: () => print('Delete'),
                )),
            Divider(
              height: 0.0,
            ),
          ],
        ),
      ),
    );
  }

  void _openHome() {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => Navigator.pushReplacementNamed(context, 'login'));
  }
}
