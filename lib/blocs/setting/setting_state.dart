import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/data/models/account.dart';

class SettingState {
  User? user;
  Account? account;
  ViewState viewState;
  SettingState({
    this.user,
    this.account,
    required this.viewState,
  });

  factory SettingState.initial() => SettingState(viewState: ViewState.isNormal);

  SettingState update({
    Account? account,
    User? user,
    ViewState? viewState,
  }) =>
      SettingState(
        account: account ?? this.account,
        user: user ?? this.user,
        viewState: viewState ?? this.viewState,
      );
}
