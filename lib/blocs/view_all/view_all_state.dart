import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/data/models/film_data.dart';

class ViewAllState {
  List<FilmData> listFilmData;
  ViewState viewState;
  int pageCurrent;
  bool isSelectLoadMore;
  bool isLastPage;
  String? message;
  ViewAllState({
    required this.listFilmData,
    required this.viewState,
    required this.pageCurrent,
    required this.isSelectLoadMore,
    required this.isLastPage,
    this.message,
  });

  ViewAllState update({
    List<FilmData>? listFilmData,
    ViewState? viewState,
    int? pageCurrent,
    bool? isSelectLoadMore,
    bool? isLastPage,
    String? message,
  }) {
    return ViewAllState(
      listFilmData: listFilmData ?? this.listFilmData,
      viewState: viewState ?? this.viewState,
      pageCurrent: pageCurrent ?? this.pageCurrent,
      isSelectLoadMore: isSelectLoadMore ?? this.isSelectLoadMore,
      isLastPage: isLastPage ?? this.isLastPage,
      message: message ?? this.message,
    );
  }
}
