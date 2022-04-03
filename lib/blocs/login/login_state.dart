import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_ticket/common/app_strings.dart';

import 'package:movie_ticket/common/view_state.dart';

class LoginState {
  bool isValidateEmail;
  bool isValidatePassword;
  ViewState viewState;
  bool showPassword;
  User? user;
  String? message;

  LoginState({
    required this.isValidateEmail,
    required this.isValidatePassword,
    required this.viewState,
    required this.showPassword,
    this.user,
    this.message,
  });

  factory LoginState.initial() => LoginState(
      isValidateEmail: true,
      isValidatePassword: true,
      viewState: ViewState.isNormal,
      message: '',
      showPassword: false);

  factory LoginState.loading() => LoginState(
      isValidateEmail: true,
      isValidatePassword: true,
      viewState: ViewState.isLoading,
      showPassword: false,
      message: AppStrings.signinIsLogin
      );

  factory LoginState.failure(String? message) => LoginState(
      isValidateEmail: true,
      isValidatePassword: true,
      viewState: ViewState.isFailure,
      message: message ?? AppStrings.signinIsFailure,
      showPassword: false
      );

  factory LoginState.success({required User user}) => LoginState(
      isValidateEmail: true,
      isValidatePassword: true,
      viewState: ViewState.isSuccess,
      user: user,
      showPassword: false,
      message: AppStrings.signinIsSuccess
      );

  LoginState update({
    bool? isValidateEmail,
    bool? isValidatePassword,
    ViewState? viewState,
    bool? showPassword,
    User? user,
    String? message,
  }) {
    return LoginState(
      isValidateEmail: isValidateEmail ?? this.isValidateEmail,
      isValidatePassword: isValidatePassword ?? this.isValidatePassword,
      viewState: viewState ?? this.viewState,
      showPassword: showPassword ?? this.showPassword,
      user: user ?? this.user,
      message: message ?? this.message,
    );
  }
}
