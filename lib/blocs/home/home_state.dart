import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/data/models/film_data.dart';

class HomeState {
  List<FilmData> listTopRated;
  List<FilmData> listNowPlaying;
  List<FilmData> listComingSoon;
  ViewState viewState;
  String? message;

  HomeState({
    required this.listTopRated,
    required this.listNowPlaying,
    required this.listComingSoon,
    required this.viewState,
    this.message,
  });

  factory HomeState.initial() => HomeState(
        listTopRated: [],
        listNowPlaying: [],
        listComingSoon: [],
        viewState: ViewState.isNormal,
      );

  HomeState update({
    List<FilmData>? listTopRated,
    List<FilmData>? listNowPlaying,
    List<FilmData>? listComingSoon,
    ViewState? viewState,
    String? message,
  }) {
    return HomeState(
      listTopRated: listTopRated ?? this.listTopRated,
      listNowPlaying: listNowPlaying ?? this.listNowPlaying,
      listComingSoon: listComingSoon ?? this.listComingSoon,
      viewState: viewState ?? this.viewState,
      message: message ?? this.message,
    );
  }

  @override
  String toString() {
    return 'HomeState(listTopRated: $listTopRated, listNowPlaying: $listNowPlaying, listComingSoon: $listComingSoon, viewState: $viewState, message: $message)';
  }
}