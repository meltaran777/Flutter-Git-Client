import 'package:bloc/bloc.dart';
import 'package:github_client_flutter/domain/interactor/auth_interactor.dart';
import 'package:github_client_flutter/domain/interactor/user_interactor.dart';
import 'package:github_client_flutter/ui/screen/home/bloc/home_event.dart';
import 'package:github_client_flutter/ui/screen/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  AuthInteractor authInteractor = authInteractorInstance;
  UserInteractor userInteractor = userIntaractorInstance;

  @override
  HomeState get initialState {
    return InitialState();
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is LogoutEvent) {
      final isLoggedOut = await authInteractor.deleteToken();
      yield IsLoggedOutState();
    }
    if (event is LoadRepositoriesEvent) {
      yield RepositoriesLoadingState();
      yield* _mapFetchReposToState();
    }
  }

  Stream<HomeState> _mapFetchReposToState() async* {
    try {
      final repos = await userInteractor.getMyRepositories();
      yield RepositoriesLoadedState(repos);
    } catch (_) {
      yield RepositoriesNotLoadedState();
    }
  }

  void dispose() {}
}
