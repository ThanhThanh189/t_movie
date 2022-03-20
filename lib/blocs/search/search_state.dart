import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/data/models/film_data.dart';

class SearchState {
  List<FilmData> listFilmData;
  bool isClear;
  ViewState viewState;
  String? message;
  SearchState({
    required this.listFilmData,
    required this.isClear,
    required this.viewState,
    this.message,
  });

  factory SearchState.initial() => SearchState(
      listFilmData: [],
      isClear: false,
      viewState: ViewState.isNormal,
      message: '');

  SearchState update({
    List<FilmData>? listFilmData,
    bool? isClear,
    ViewState? viewState,
    String? message,
  }) {
    return SearchState(
      listFilmData: listFilmData ?? this.listFilmData,
      isClear: isClear ?? this.isClear,
      viewState: viewState ?? this.viewState,
      message: message ?? this.message,
    );
  }
}
