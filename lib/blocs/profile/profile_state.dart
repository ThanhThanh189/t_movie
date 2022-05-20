import 'package:movie_ticket/common/view_state.dart';

class ProfileState {
  String? uid;
  String? photoURLOld;
  String? photoURLNew;
  String? fullName;
  bool isValidateFullName;
  bool isValidatePassword;
  bool isValidateConfirmPassword;
  String? email;
  ViewState viewState;
  String? message;
  bool isValidatePasswordOld;
  ProfileState({
    this.uid,
    this.photoURLOld,
    this.photoURLNew,
    this.fullName,
    required this.isValidateFullName,
    required this.isValidatePassword,
    required this.isValidateConfirmPassword,
    this.email,
    required this.viewState,
    required this.isValidatePasswordOld,
    this.message,
  });

  factory ProfileState.initial() => ProfileState(
      photoURLOld: null,
      photoURLNew: null,
      fullName: null,
      isValidateFullName: false,
      isValidatePassword: false,
      isValidateConfirmPassword: false,
      email: null,
      viewState: ViewState.isNormal,
      isValidatePasswordOld: true,
      message: null);

  ProfileState update({
    String? uid,
    String? photoURLOld,
    String? photoURLNew,
    String? fullName,
    bool? isValidateFullName,
    bool? isValidatePassword,
    bool? isValidateConfirmPassword,
    String? email,
    ViewState? viewState,
    bool? isValidatePasswordOld,
    bool? isShowPasswordOld,
    bool? isShowPasswordNew,
    String? message,
  }) {
    return ProfileState(
      uid: uid ?? this.uid,
      photoURLOld: photoURLOld ?? this.photoURLOld,
      photoURLNew: photoURLNew ?? this.photoURLNew,
      fullName: fullName ?? this.fullName,
      isValidateFullName: isValidateFullName ?? this.isValidateFullName,
      isValidatePassword: isValidatePassword ?? this.isValidatePassword,
      isValidateConfirmPassword:
          isValidateConfirmPassword ?? this.isValidateConfirmPassword,
      email: email ?? this.email,
      viewState: viewState ?? this.viewState,
      isValidatePasswordOld:
          isValidatePasswordOld ?? this.isValidatePasswordOld,
      message: message ?? this.message,
    );
  }
}
