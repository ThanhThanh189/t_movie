import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/favorite/favorite_event.dart';
import 'package:movie_ticket/blocs/favorite/favorite_state.dart';
import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/data/database/film_databases.dart';
import 'package:movie_ticket/data/models/film_data.dart';
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
          final user = await userRepository.getCurrentUser();
          emit.call(
            state.update(uid: user!.uid),
          );
          final listFilmFavorite =
              await filmDatabase.getFilmFavorite(uid: user.uid);

          if (listFilmFavorite.isNotEmpty) {
            emit.call(state.update(
                viewState: ViewState.isSuccess,
                listFilmFavorite: listFilmFavorite));
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
          List<FilmData> listFilmFavoriteNew = [];
          for (var item in state.listFilmFavorite) {
            if (item.id != event.id) {
              listFilmFavoriteNew.add(item);
            }
          }
          await filmDatabase.addListFilmFavorite(listFilmFavorite: listFilmFavoriteNew, uid: state.uid!);

          if (state.listFilmFavorite.length != listFilmFavoriteNew.length) {
            emit.call(
              state.update(
                  viewState: ViewState.isSuccess,
                  listFilmFavorite: listFilmFavoriteNew,
                  message: 'Delete success'),
            );
            emit.call(
                state.update(viewState: ViewState.isNormal, message: null));
          } else {
            emit.call(state.update(
                viewState: ViewState.isFailure, message: 'Can\t be deleted'));
            emit.call(
                state.update(viewState: ViewState.isNormal, message: null));
          }
        } catch (e) {
          emit.call(
              state.update(viewState: ViewState.isFailure, message: 'Can\t be deleted'));
          emit.call(state.update(viewState: ViewState.isNormal, message: null));
        }
      }
      if (event is RefreshFavoriteEvent) {
        emit.call(state.update(viewState: ViewState.isLoading));
        emit.call(state.update(
            viewState: ViewState.isSuccess,
            listFilmFavorite: state.listFilmFavorite,
            message: null));
      }
    });
  }
}
