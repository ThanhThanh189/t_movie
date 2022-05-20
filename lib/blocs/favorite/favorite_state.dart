import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/data/models/film_data.dart';

class FavoriteState {
  String? uid;
  List<FilmData> listFilmFavorite;
  ViewState viewState;
  String? message;
  FavoriteState({
    this.uid,
    required this.listFilmFavorite,
    required this.viewState,
    this.message,
  });

  factory FavoriteState.init() => FavoriteState(
        listFilmFavorite: [],
        viewState: ViewState.isLoading,
        message: null,
      );

  FavoriteState update({
    String? uid,
    List<FilmData>? listFilmFavorite,
    ViewState? viewState,
    String? message,
  }) {
    return FavoriteState(
      uid: uid ?? this.uid,
      listFilmFavorite: listFilmFavorite ?? this.listFilmFavorite,
      viewState: viewState ?? this.viewState,
      message: message ?? this.message,
    );
  }
}
