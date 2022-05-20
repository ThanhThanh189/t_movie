import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/data/models/account.dart';

class CheckoutState {
  String? uid;
  Account? account;
  ViewState viewState;
  bool isAddTicket;
  String? message;
  int wallet;
  CheckoutState({
    required this.viewState,
    required this.isAddTicket,
    this.message,
    this.uid,
    this.account,
    required this.wallet,
  });

  CheckoutState copyWith({
    ViewState? viewState,
    bool? isAddTicket,
    Account? account,
    String? message,
    String? uid,
    int? wallet,
  }) {
    return CheckoutState(
        uid: uid ?? this.uid,
        viewState: viewState ?? this.viewState,
        account: account ?? this.account,
        isAddTicket: isAddTicket ?? this.isAddTicket,
        wallet: wallet ?? this.wallet,
        message: message);
  }
}
