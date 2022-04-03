import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_ticket/common/view_state.dart';

class RegisterState {
  bool isValidateFullName;
  bool isValidateEmail;
  bool isValidatePassword;
  bool isValidateConfirmPassword;
  String? imageAvatar;
  ViewState viewState;
  bool showPassword;
  bool showConfirmPassword;
  User? user;
  String? message;

  RegisterState({
    required this.isValidateFullName,
    required this.isValidateEmail,
    required this.isValidatePassword,
    required this.isValidateConfirmPassword,
    this.imageAvatar,
    required this.viewState,
    required this.showPassword,
    required this.showConfirmPassword,
    this.user,
    this.message,
  });

  factory RegisterState.initial() => RegisterState(
      isValidateFullName: true,
      isValidateEmail: true,
      isValidatePassword: true,
      isValidateConfirmPassword: true,
      viewState: ViewState.isNormal,
      showPassword: false,
      showConfirmPassword: false,
      message: null);

  RegisterState update({
    bool? isValidateFullName,
    bool? isValidateEmail,
    bool? isValidatePassword,
    bool? isValidateConfirmPassword,
    String? imageAvatar,
    ViewState? viewState,
    bool? showPassword,
    bool? showConfirmPassword,
    bool? isRemoveImage,
    User? user,
    String? message,
  }) {
    return RegisterState(
      isValidateFullName: isValidateFullName ?? this.isValidateFullName,
      isValidateEmail: isValidateEmail ?? this.isValidateEmail,
      isValidatePassword: isValidatePassword ?? this.isValidatePassword,
      isValidateConfirmPassword:
          isValidateConfirmPassword ?? this.isValidateConfirmPassword,
      imageAvatar: isRemoveImage == true ? null : imageAvatar ?? this.imageAvatar,
      viewState: viewState ?? this.viewState,
      showPassword: showPassword ?? this.showPassword,
      showConfirmPassword: showConfirmPassword ?? this.showConfirmPassword,
      user: user ?? this.user,
      message: message,
    );
  }
}
