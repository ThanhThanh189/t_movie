import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/home/home_event.dart';
import 'package:movie_ticket/blocs/home/home_state.dart';
import 'package:movie_ticket/common/global.dart';
import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/data/models/film_data.dart';
import 'package:movie_ticket/data/repositories/film_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  FilmRepository filmRepository;
  HomeBloc({required this.filmRepository}) : super(HomeState.initial()) {
    on<HomeEvent>((event, emit) async {
      if (event is StartedHomeEvent) {
        emit.call(state.update(viewState: ViewState.isLoading));
        try {
          List<FilmData>? listTopRated =
              await filmRepository.getListFilm(Global.listTopRated, 1);
          List<FilmData>? listNowPlaying =
              await filmRepository.getListFilm(Global.listNowPlaying, 1);
          List<FilmData>? listComingSoon =
              await filmRepository.getListFilm(Global.listComingSoon, 1);

          emit.call(state.update(
              viewState: ViewState.isSuccess,
              listNowPlaying: listNowPlaying,
              listComingSoon: listComingSoon,
              listTopRated: listTopRated));
        } catch (_) {
          emit.call(
              state.update(viewState: ViewState.isFailure, message: 'Error'));
          emit.call(state.update(viewState: ViewState.isNormal, message: ''));
        }
      }
    });
  }
}
