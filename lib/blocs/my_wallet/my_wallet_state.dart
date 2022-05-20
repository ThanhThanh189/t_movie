import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/data/models/account.dart';
import 'package:movie_ticket/presentation/widgets/contants/contants.dart';

class MyWalletState {
  final Account? account;
  final String? uid;
  final int money;
  final TopUpOption? topUpOption;
  final int? moneyKeyboard;
  final ViewState viewState;
  final String? message;
  MyWalletState({
    this.account,
    this.uid,
    required this.money,
    this.moneyKeyboard,
    this.topUpOption,
    required this.viewState,
    this.message,
  });

  MyWalletState copyWith({
    Account? account,
    int? money,
    String? uid,
    TopUpOption? topUpOption,
    int? moneyKeyboard,
    ViewState? viewState,
    String? message,
  }) {
    return MyWalletState(
      account: account ?? this.account,
      uid: uid ?? this.uid,
      viewState: viewState ?? this.viewState,
      moneyKeyboard: moneyKeyboard ?? this.moneyKeyboard,
      money: money ?? this.money,
      topUpOption: topUpOption,
      message: message,
    );
  }
}
