import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/checkout/checkout_event.dart';
import 'package:movie_ticket/blocs/checkout/checkout_state.dart';
import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/data/models/account.dart';
import 'package:movie_ticket/data/repositories/film_database.dart';
import 'package:movie_ticket/data/repositories/user_repository.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  FilmDatabase filmDatabase = FilmDatabase();
  UserRepository userRepository = UserRepository();
  CheckoutBloc()
      : super(CheckoutState(
          wallet: 0,
          viewState: ViewState.isNormal,
          isAddTicket: false,
        )) {
    on<CheckoutEvent>(
      (event, emit) async {
        if (event is StartedCheckoutEvent) {
          final user = await userRepository.getCurrentUser();
          if (user != null) {
            emit.call(state.copyWith(uid: user.uid));
            final account = await filmDatabase.getAccount(uid: user.uid);
            emit.call(
                state.copyWith(wallet: account?.wallet, account: account));
          }
        }
        if (event is SelectCheckoutEvent) {
          emit.call(state.copyWith(
              viewState: ViewState.isLoading, message: 'is checking out...'));
          final listTicketBooked = await filmDatabase.getAllTicket();
          List<String> listSeatBooked = [];
          for (var item in listTicketBooked) {
            if (item.cinemaName.compareTo(event.ticket.cinemaName) == 0 &&
                item.cinemaTime.compareTo(event.ticket.cinemaTime) == 0 &&
                item.dateTime == event.ticket.dateTime &&
                item.filmData.id == event.ticket.filmData.id) {
              listSeatBooked.addAll(item.listSeat);
            }
          }
          //Checkout
          if (event.ticket.listSeat
              .where((element) => listSeatBooked.contains(element.trim()))
              .isNotEmpty) {
            emit.call(state.copyWith(
                viewState: ViewState.isFailure, message: 'Seat is Booked'));
            emit.call(state.copyWith(viewState: ViewState.isNormal));
          } else {
            if (state.uid != null) {
              final result = await filmDatabase.addMyTicket(
                  ticket: event.ticket, uid: state.uid!);
              await filmDatabase.addRevenue(
                  ticket: event.ticket, uid: state.uid!);
              int walletOld = state.account?.wallet ?? 0;

              await filmDatabase.addAndUpdateAccount(
                  uid: state.uid!,
                  account: Account(
                    id: state.account?.id,
                    displayName: state.account?.displayName,
                    email: state.account?.email,
                    photo: state.account?.photo,
                    wallet: walletOld - event.ticket.total,
                  ));
              emit.call(
                state.copyWith(
                    isAddTicket: result,
                    viewState:
                        result ? ViewState.isSuccess : ViewState.isFailure,
                    message: result == true
                        ? 'Checkout is success'
                        : 'Checkout is failure'),
              );
              emit.call(
                state.copyWith(viewState: ViewState.isNormal),
              );
            }
          }
        }
      },
    );
  }
}
