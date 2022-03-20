import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/data/models/film_data.dart';

class FavoriteState {
  List<FilmData> listFilmData;
  ViewState viewState;
  String? message;
  FavoriteState({
    required this.listFilmData,
    required this.viewState,
    this.message,
  });

  factory FavoriteState.init() => FavoriteState(
      listFilmData: [], viewState: ViewState.isNormal, message: null);

  FavoriteState update({
    List<FilmData>? listFilmData,
    ViewState? viewState,
    String? message,
  }) {
    return FavoriteState(
      listFilmData: listFilmData ?? this.listFilmData,
      viewState: viewState ?? this.viewState,
      message: message ?? this.message,
    );
  }
}
