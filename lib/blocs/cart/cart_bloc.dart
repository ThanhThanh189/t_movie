import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/cart/cart_event.dart';
import 'package:movie_ticket/blocs/cart/cart_state.dart';
import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/data/database/film_database.dart';
import 'package:movie_ticket/data/models/film_data.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  FilmDatabase filmDatabase = FilmDatabase.instance;
  CartBloc() : super(CartState.initial()) {
    on<CartEvent>((event, emit) async {
      if (event is StartedCartEvent) {
        emit.call(state.update(viewState: ViewState.isLoading));
        try {
          var listCart = await filmDatabase.readAllFilmsCart();

          if (listCart!.isNotEmpty) {
            emit.call(state.update(
                viewState: ViewState.isSuccess, listFilmData: listCart));
            emit.call(state.update(viewState: ViewState.isNormal));
          } else {
            emit.call(state.update(
                viewState: ViewState.isFailure, message: 'Don\'t has data'));
            state.update(viewState: ViewState.isNormal, message: null);
          }
        } catch (e) {
          emit.call(
              state.update(viewState: ViewState.isFailure, message: 'Error'));
          state.update(viewState: ViewState.isNormal, message: null);
        }
      }
      if (event is RefreshCartEvent) {}
      if (event is SelectCartEvent) {
        try {
          if (event.isSelected) {
            var listFilmDataSelectedNew = state.listFilmDataSelected;
            listFilmDataSelectedNew.add(event.filmData);

            emit.call(state.update(
                listFilmDataSelected: listFilmDataSelectedNew,
                isSelectedAll: state.listFilmDataSelected.length ==
                        state.listFilmData.length
                    ? true
                    : false));
          } else {
            state.listFilmDataSelected.remove(event.filmData);
            emit.call(state.update(
                listFilmDataSelected: state.listFilmDataSelected,
                isSelectedAll: state.listFilmDataSelected.length ==
                        state.listFilmData.length
                    ? true
                    : false));
          }
        } catch (e) {
          emit.call(
              state.update(viewState: ViewState.isFailure, message: 'Error'));
          state.update(viewState: ViewState.isNormal, message: null);
        }
      }
      if (event is SelectAllCartEvent) {
        try {
          if (event.isSelected) {
            List<FilmData> listFilmDataSelected = [];
            listFilmDataSelected.addAll(state.listFilmData);
            emit.call(state.update(
                listFilmDataSelected: listFilmDataSelected,
                isSelectedAll: true));
          } else {
            emit.call(
                state.update(listFilmDataSelected: [], isSelectedAll: false));
          }
        } catch (e) {
          emit.call(
              state.update(viewState: ViewState.isFailure, message: 'Error'));
          emit.call(state.update(viewState: ViewState.isNormal, message: null));
        }
      }
      if (event is DeleteCartEvent) {
        try {
          bool checkDelete = await filmDatabase.deleteFilmsCartByID(event.id);
          if (checkDelete) {
            var listFilmData = await filmDatabase.readAllFilmsCart();
            if (listFilmData!.isNotEmpty) {
              emit.call(state.update(
                  viewState: ViewState.isSuccess,
                  listFilmData: listFilmData,
                  listFilmDataSelected: [],
                  message: 'Delete success'));
              emit.call(
                  state.update(viewState: ViewState.isNormal, message: null));
            } else {
              emit.call(state.update(
                  viewState: ViewState.isFailure, message: 'Don\t has data'));
              emit.call(
                  state.update(viewState: ViewState.isNormal, message: null));
            }
          } else {
            emit.call(state.update(
                viewState: ViewState.isFailure, message: 'Can\t be deleted'));
            emit.call(
                state.update(viewState: ViewState.isNormal, message: null));
          }
        } catch (e) {
          emit.call(
              state.update(viewState: ViewState.isFailure, message: 'Error'));
          emit.call(state.update(viewState: ViewState.isNormal, message: null));
        }
      }
      if (event is PaymentCartEvent) {
        try {
          for (var item in event.listFilmData) {
            await filmDatabase.deleteFilmsCartByID(item.id);
          }
          var listFilmData = await filmDatabase.readAllFilmsCart();
          emit.call(state.update(
              viewState: ViewState.isSuccess,
              listFilmData: listFilmData ?? [],
              message: 'Payment success',
              listFilmDataSelected: [],
              isSelectedAll: false));
          emit.call(state.update(viewState: ViewState.isNormal, message: null));
        } catch (e) {
          emit.call(
              state.update(viewState: ViewState.isFailure, message: 'Error'));
          emit.call(state.update(viewState: ViewState.isNormal, message: null));
        }
      }
    });
  }
}
