import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/cart/cart_event.dart';
import 'package:movie_ticket/blocs/cart/cart_state.dart';
import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/data/models/ticket.dart';
import 'package:movie_ticket/data/repositories/film_database.dart';
import 'package:movie_ticket/data/repositories/user_repository.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  FilmDatabase filmDatabase = FilmDatabase();
  UserRepository userRepository = UserRepository();
  CartBloc() : super(CartState.initial()) {
    on<CartEvent>(
      (event, emit) async {
        if (event is StartedCartEvent) {
          emit.call(state.update(viewState: ViewState.isLoading));
          try {
            final user = await userRepository.getCurrentUser();
            if (user != null) {
              emit.call(state.update(uid: user.uid));
              var listMyTicket = await filmDatabase.getMyTicket(uid: user.uid);
              if (listMyTicket.isNotEmpty) {
                emit.call(state.update(
                    viewState: ViewState.isSuccess,
                    listMyTicket: listMyTicket));
                emit.call(state.update(viewState: ViewState.isNormal));
              }
            }
            emit.call(
                state.update(viewState: ViewState.isNormal, message: null));
          } catch (e) {
            emit.call(state.update(
                viewState: ViewState.isFailure, message: 'Don\'t has data'));
            state.update(viewState: ViewState.isNormal, message: null);
          }
        }
        if (event is DeleteCartEvent) {
          try {
            List<Ticket> listMyTicket = [];
            for (var item in state.listMyTicket) {
              if (item.id != event.id) {
                listMyTicket.add(item);
              }
            }
            if (listMyTicket.length != state.listMyTicket.length) {
              await filmDatabase.deleteMyTicket(
                  uid: state.uid!, listTicket: listMyTicket);
              emit.call(
                state.update(
                    viewState: ViewState.isSuccess,
                    listMyTicket: listMyTicket,
                    listFilmDataSelected: [],
                    message: 'Delete success'),
              );
              emit.call(
                  state.update(viewState: ViewState.isNormal, message: null));
            } else {
              emit.call(state.update(
                  viewState: ViewState.isFailure, message: 'Delete failure'));
              emit.call(
                  state.update(viewState: ViewState.isNormal, message: null));
            }
          } catch (e) {
            emit.call(state.update(
                viewState: ViewState.isFailure, message: 'Don\'t has data'));
            emit.call(
                state.update(viewState: ViewState.isNormal, message: null));
          }
        }
      },
    );
  }
}
