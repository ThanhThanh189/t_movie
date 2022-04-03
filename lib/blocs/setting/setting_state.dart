import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_ticket/common/view_state.dart';

class SettingState {
  User? user;
  ViewState viewState;
  SettingState({
    this.user,
    required this.viewState,
  });

  factory SettingState.initial() => SettingState(viewState: ViewState.isNormal);

  SettingState update({
    User? user,
    ViewState? viewState,
  }) =>
      SettingState(
        user: user ?? this.user,
        viewState: viewState ?? this.viewState,
      );
}
