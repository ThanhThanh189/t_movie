import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/my_wallet/my_wallet_event.dart';
import 'package:movie_ticket/blocs/my_wallet/my_wallet_state.dart';
import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/data/models/account.dart';
import 'package:movie_ticket/data/repositories/film_database.dart';
import 'package:movie_ticket/data/repositories/user_repository.dart';

class MyWalletBloc extends Bloc<MyWalletEvent, MyWalletState> {
  UserRepository userRepository = UserRepository();
  FilmDatabase filmDatabase = FilmDatabase();
  MyWalletBloc()
      : super(MyWalletState(
            money: 0, viewState: ViewState.isNormal)) {
    on<MyWalletEvent>(
      (event, emit) async {
        if (event is StartedMyWalletEvent) {
          emit.call(state.copyWith(viewState: ViewState.isLoading));
          final user = await userRepository.getCurrentUser();
          if (user != null) {
            final account = await filmDatabase.getAccount(uid: user.uid);
            emit.call(
              state.copyWith(account: account, uid: user.uid),
            );
          }
        }
        if (event is SelectOptionMyWalletEvent) {
          if (state.topUpOption != event.topUpOption) {
            emit.call(state.copyWith(
                topUpOption: event.topUpOption, moneyKeyboard: 0));
          } else {
            emit.call(state.copyWith(moneyKeyboard: 0));
          }
        }
        if (event is InputMoneyMyWalletEvent) {
          emit.call(state.copyWith(
              moneyKeyboard: event.moneyKeyboard,));
        }
        if (event is TopUpMyWalletEvent) {
          try {
            emit.call(state.copyWith(
                viewState: ViewState.isLoading,
                message: 'Waiting a second...'));
            int moneyOld = state.account?.wallet ?? 0;
            int moneyNew = moneyOld + event.money;
            final result = await filmDatabase.addAndUpdateAccount(
              uid: state.uid ?? '',
              account: Account(
                id: state.account?.id ?? state.uid,
                displayName: state.account?.displayName,
                email: state.account?.email,
                photo: state.account?.photo,
                wallet: moneyNew,
              ),
            );
            if (result) {
              final moneyNew =
                  await filmDatabase.getAccount(uid: state.uid ?? '');
              emit.call(
                state.copyWith(
                    money: moneyNew?.wallet,
                    viewState: ViewState.isSuccess,
                    message: 'Top up success'),
              );
              emit.call(state.copyWith(viewState: ViewState.isNormal));
            } else {
              emit.call(state.copyWith(
                  viewState: ViewState.isFailure, message: 'Top up failure'));
              emit.call(state.copyWith(viewState: ViewState.isNormal));
            }
          } catch (_) {
            emit.call(state.copyWith(
                viewState: ViewState.isFailure, message: 'Top up is error'));
            emit.call(state.copyWith(viewState: ViewState.isNormal));
          }
        }
      },
    );
  }
}
