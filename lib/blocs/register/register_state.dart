import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_ticket/common/view_state.dart';

class RegisterState {
  bool isValidateEmail;
  bool isValidatePassword;
  bool isValidateConfirmPassword;
  ViewState viewState;
  bool showPassword;
  bool showConfirmPassword;
  User? user;
  String? message;

  RegisterState({
    required this.isValidateEmail,
    required this.isValidatePassword,
    required this.isValidateConfirmPassword,
    required this.viewState,
    required this.showPassword,
    required this.showConfirmPassword,
    this.user,
    this.message,
  });

  factory RegisterState.initial() => RegisterState(
      isValidateEmail: true,
      isValidatePassword: true,
      isValidateConfirmPassword: true,
      viewState: ViewState.isNormal,
      showPassword: false,
      showConfirmPassword: false,
      message: null);

  factory RegisterState.isLoading({String? message}) => RegisterState(
      isValidateEmail: true,
      isValidatePassword: true,
      isValidateConfirmPassword: true,
      viewState: ViewState.isLoading,
      showPassword: false,
      showConfirmPassword: false,
      message: message);

  factory RegisterState.isFailure({String? message}) => RegisterState(
      isValidateEmail: true,
      isValidatePassword: true,
      isValidateConfirmPassword: true,
      viewState: ViewState.isFailure,
      showPassword: false,
      showConfirmPassword: false,
      message: message);

  factory RegisterState.isSuccess({User? user, String? message}) =>
      RegisterState(
          isValidateEmail: true,
          isValidatePassword: true,
          isValidateConfirmPassword: true,
          viewState: ViewState.isSuccess,
          showPassword: false,
          showConfirmPassword: false,
          user: user,
          message: message);

  RegisterState update({
    bool? isValidateEmail,
    bool? isValidatePassword,
    bool? isValidateConfirmPassword,
    ViewState? viewState,
    bool? showPassword,
    bool? showConfirmPassword,
    User? user,
    String? message,
  }) {
    return RegisterState(
      isValidateEmail: isValidateEmail ?? this.isValidateEmail,
      isValidatePassword: isValidatePassword ?? this.isValidatePassword,
      isValidateConfirmPassword:
          isValidateConfirmPassword ?? this.isValidateConfirmPassword,
      viewState: viewState ?? this.viewState,
      showPassword: showPassword ?? this.showPassword,
      showConfirmPassword: showConfirmPassword ?? this.showConfirmPassword,
      user: user ?? this.user,
      message: message ?? this.message,
    );
  }
}
