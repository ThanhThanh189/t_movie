import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/data/models/film_data.dart';
import 'package:movie_ticket/data/models/ticket.dart';

class CartState {
  List<FilmData> listFilmDataSelected;
  List<Ticket> listMyTicket;
  bool isSelectedAll;
  String? uid;
  ViewState viewState;
  String? message;

  CartState({
    required this.listFilmDataSelected,
    required this.viewState,
    required this.isSelectedAll,
    required this.listMyTicket,
    this.uid,
    this.message,
  });

  factory CartState.initial() => CartState(
      listFilmDataSelected: [],
      listMyTicket: [],
      viewState: ViewState.isLoading,
      isSelectedAll: false,
      message: null);

  CartState update({
    List<FilmData>? listFilmData,
    List<FilmData>? listFilmDataSelected,
    List<Ticket>? listMyTicket,
    ViewState? viewState,
    bool? isSelectedAll,
    String? uid,
    String? message,
  }) {
    return CartState(
      listFilmDataSelected: listFilmDataSelected ?? this.listFilmDataSelected,
      listMyTicket: listMyTicket ?? this.listMyTicket,
      viewState: viewState ?? this.viewState,
      isSelectedAll: isSelectedAll ?? this.isSelectedAll,
      uid: uid ?? this.uid,
      message: message ?? this.message,
    );
  }
}
