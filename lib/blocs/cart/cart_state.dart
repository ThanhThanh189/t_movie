import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/data/models/film_data.dart';

class CartState {
  List<FilmData> listFilmData;
  List<FilmData> listFilmDataSelected;
  bool isSelectedAll;
  ViewState viewState;
  String? message;

  CartState({
    required this.listFilmData,
    required this.listFilmDataSelected,
    required this.viewState,
    required this.isSelectedAll,
    this.message,
  });

  factory CartState.initial() => CartState(
      listFilmData: [],
      listFilmDataSelected: [],
      viewState: ViewState.isNormal,
      isSelectedAll: false,
      message: null);

  CartState update({
    List<FilmData>? listFilmData,
    List<FilmData>? listFilmDataSelected,
    ViewState? viewState,
    bool? isSelectedAll,
    String? message,
  }) {
    return CartState(
      listFilmData: listFilmData ?? this.listFilmData,
      listFilmDataSelected: listFilmDataSelected ?? this.listFilmDataSelected,
      viewState: viewState ?? this.viewState,
      isSelectedAll: isSelectedAll ?? this.isSelectedAll,
      message: message ?? this.message,
    );
  }
}
