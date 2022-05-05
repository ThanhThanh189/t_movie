import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/checkout/checkout_event.dart';
import 'package:movie_ticket/blocs/checkout/checkout_state.dart';
import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/data/repositories/film_database.dart';
import 'package:movie_ticket/data/repositories/user_repository.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  FilmDatabase filmDatabase = FilmDatabase();
  UserRepository userRepository = UserRepository();
  CheckoutBloc()
      : super(
            CheckoutState(viewState: ViewState.isNormal, isAddTicket: false)) {
    on<CheckoutEvent>((event, emit) async {
      if (event is StartedCheckoutEvent) {}
      if (event is SelectCheckoutEvent) {
        final user = await userRepository.getCurrentUser();
        final result = await filmDatabase.addMyTicket(
            ticket: event.ticket, uid: user!.uid);
        emit.call(
          state.copyWith(
              isAddTicket: result,
              viewState: result ? ViewState.isSuccess : ViewState.isFailure,
              message: result == true
                  ? 'Checkout is success'
                  : 'Checkout is failure'),
        );
        emit.call(
          state.copyWith(viewState: ViewState.isNormal),
        );
      }
    });
  }
}
