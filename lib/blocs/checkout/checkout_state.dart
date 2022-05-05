import 'package:movie_ticket/common/view_state.dart';

class CheckoutState {
  ViewState viewState;
  bool isAddTicket;
  String? message;
  CheckoutState({
    required this.viewState,
    required this.isAddTicket,
    this.message,
  });

  CheckoutState copyWith({
    ViewState? viewState,
    bool? isAddTicket,
    String? message,
  }) {
    return CheckoutState(
      viewState: viewState ?? this.viewState,
      isAddTicket: isAddTicket ?? this.isAddTicket,
      message: message
    );
  }
}
