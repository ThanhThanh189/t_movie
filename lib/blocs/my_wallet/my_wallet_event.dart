import 'package:equatable/equatable.dart';

import 'package:movie_ticket/presentation/widgets/contants/contants.dart';

abstract class MyWalletEvent extends Equatable {}

class StartedMyWalletEvent extends MyWalletEvent {
  @override
  List<Object?> get props => [];
}

class TopUpMyWalletEvent extends MyWalletEvent {
  final int money;
  TopUpMyWalletEvent({
    required this.money,
  });
  @override
  List<Object?> get props => [money];
}

class SelectOptionMyWalletEvent extends MyWalletEvent {
  final TopUpOption topUpOption;
  SelectOptionMyWalletEvent({
    required this.topUpOption,
  });
  @override
  List<Object?> get props => [topUpOption];
}

class InputMoneyMyWalletEvent extends MyWalletEvent {
  final int? moneyKeyboard;
  InputMoneyMyWalletEvent({
     this.moneyKeyboard,
  });
  @override
  List<Object?> get props => [moneyKeyboard];
}
