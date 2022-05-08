import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/home/home_event.dart';
import 'package:movie_ticket/blocs/home/home_state.dart';
import 'package:movie_ticket/common/global.dart';
import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/data/models/film_data.dart';
import 'package:movie_ticket/data/repositories/film_database.dart';
import 'package:movie_ticket/data/repositories/film_repository.dart';
import 'package:movie_ticket/data/repositories/user_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  FilmDatabase filmDatabase = FilmDatabase();
  FilmRepository filmRepository = FilmRepositoryImp();
  UserRepository userRepository = UserRepository();
  HomeBloc() : super(HomeState.initial()) {
    on<HomeEvent>(
      (event, emit) async {
        if (event is StartedHomeEvent) {
          emit.call(
            state.update(viewState: ViewState.isLoading),
          );
          await Future.delayed(const Duration(milliseconds: 500));
          emit.call(
            state.update(viewState: ViewState.isNormal),
          );
          try {
            final user = await userRepository.getCurrentUser();
            if (user != null) {
              final account = await filmDatabase.getAccount(uid: user.uid);
              emit.call(state.update(avatar: account?.photo));
            }
            List<FilmData>? listTopRated =
                await filmRepository.getListFilm(Global.listTopRated, 1);
            List<FilmData>? listNowPlaying =
                await filmRepository.getListFilm(Global.listNowPlaying, 1);
            List<FilmData>? listComingSoon =
                await filmRepository.getListFilm(Global.listComingSoon, 4);
            emit.call(
              state.update(
                viewState: ViewState.isSuccess,
                listNowPlaying: listNowPlaying,
                listComingSoon: listComingSoon,
                listTopRated: listTopRated,
                user: user,
              ),
            );
          } catch (_) {
            emit.call(
              state.update(viewState: ViewState.isFailure, message: 'Error'),
            );
            emit.call(
              state.update(viewState: ViewState.isNormal),
            );
          }
        }
      },
    );
  }
}
