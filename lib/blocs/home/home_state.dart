import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/data/models/film_data.dart';

class HomeState {
  List<FilmData> listTopRated;
  List<FilmData> listNowPlaying;
  List<FilmData> listComingSoon;
  String? avatar;
  User? user;
  ViewState viewState;
  String? message;

  HomeState({
    required this.listTopRated,
    required this.listNowPlaying,
    required this.listComingSoon,
    required this.viewState,
    this.avatar,
    this.user,
    this.message,
  });

  factory HomeState.initial() => HomeState(
        listTopRated: [],
        listNowPlaying: [],
        listComingSoon: [],
        viewState: ViewState.isLoading,
      );

  HomeState update({
    List<FilmData>? listTopRated,
    List<FilmData>? listNowPlaying,
    List<FilmData>? listComingSoon,
    String? avatar,
    User? user,
    ViewState? viewState,
    String? message,
  }) {
    return HomeState(
      listTopRated: listTopRated ?? this.listTopRated,
      listNowPlaying: listNowPlaying ?? this.listNowPlaying,
      listComingSoon: listComingSoon ?? this.listComingSoon,
      avatar: avatar ?? this.avatar,
      user: user ?? this.user,
      viewState: viewState ?? this.viewState,
      message: message,
    );
  }

  @override
  String toString() {
    return 'HomeState(listTopRated: $listTopRated, listNowPlaying: $listNowPlaying, listComingSoon: $listComingSoon, viewState: $viewState, message: $message)';
  }
}
