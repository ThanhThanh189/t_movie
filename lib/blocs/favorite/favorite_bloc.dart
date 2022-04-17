import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/favorite/favorite_event.dart';
import 'package:movie_ticket/blocs/favorite/favorite_state.dart';
import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/data/database/film_databases.dart';
import 'package:movie_ticket/data/repositories/film_database.dart';
import 'package:movie_ticket/data/repositories/user_repository.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FilmDatabases filmDatabases = FilmDatabases.instance;
  FilmDatabase filmDatabase = FilmDatabase();
  UserRepository userRepository = UserRepository();

  FavoriteBloc() : super(FavoriteState.init()) {
    on<FavoriteEvent>((event, emit) async {
      if (event is StartedFavoriteEvent) {
        emit.call(state.update(viewState: ViewState.isLoading));
        try {
          var listFilmData = await filmDatabases.readAllFilmsFavorite();
          final user = await userRepository.getCurrentUser();
          await filmDatabase.addFilm();

          if (listFilmData!.isNotEmpty) {
            emit.call(state.update(
                viewState: ViewState.isSuccess, listFilmData: listFilmData));
          } else {
            emit.call(state.update(
                viewState: ViewState.isFailure, message: 'Don\t has data'));
            emit.call(
                state.update(viewState: ViewState.isNormal, message: null));
          }
        } catch (e) {
          emit.call(
              state.update(viewState: ViewState.isFailure, message: 'Error'));
          emit.call(state.update(viewState: ViewState.isNormal, message: null));
        }
      }
      if (event is DeleteFavoriteEvent) {
        try {
          bool checkDelete =
              await filmDatabases.deleteFilmsFavoriteByID(event.id);
          if (checkDelete) {
            var listFilmData = await filmDatabases.readAllFilmsFavorite();
            if (listFilmData!.isNotEmpty) {
              emit.call(state.update(
                  viewState: ViewState.isSuccess,
                  listFilmData: listFilmData,
                  message: 'Delete success'));
              emit.call(
                  state.update(viewState: ViewState.isNormal, message: null));
            } else {
              emit.call(state.update(
                  viewState: ViewState.isFailure, message: 'Don\t has data'));
              emit.call(
                  state.update(viewState: ViewState.isNormal, message: null));
            }
          } else {
            emit.call(state.update(
                viewState: ViewState.isFailure, message: 'Can\t be deleted'));
            emit.call(
                state.update(viewState: ViewState.isNormal, message: null));
          }
        } catch (e) {
          emit.call(
              state.update(viewState: ViewState.isFailure, message: 'Error'));
          emit.call(state.update(viewState: ViewState.isNormal, message: null));
        }
      }
      if (event is RefreshFavoriteEvent) {
        emit.call(state.update(viewState: ViewState.isLoading));
        emit.call(state.update(
            viewState: ViewState.isSuccess,
            listFilmData: state.listFilmData,
            message: null));
      }
    });
  }
}
