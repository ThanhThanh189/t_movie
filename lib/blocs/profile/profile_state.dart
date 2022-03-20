import 'package:movie_ticket/common/view_state.dart';

class ProfileState {
  String? photoURL;
  String? fullName;
  String? email;
  ViewState viewState;
  String? message;
  bool isValidatePasswordOld;
  bool isShowPasswordOld;
  bool isShowPasswordNew;
  ProfileState({
    this.photoURL,
    this.fullName,
    this.email,
    required this.viewState,
    required this.isValidatePasswordOld,
    required this.isShowPasswordOld,
    required this.isShowPasswordNew,
    this.message,
  });

  factory ProfileState.initial() => ProfileState(
      photoURL: null,
      fullName: null,
      email: null,
      viewState: ViewState.isNormal,
      isValidatePasswordOld: true,
      isShowPasswordOld: false,
      isShowPasswordNew: false,
      message: null);

  ProfileState update({
    String? photoURL,
    String? fullName,
    String? email,
    ViewState? viewState,
    bool? isValidatePasswordOld,
    bool? isShowPasswordOld,
    bool? isShowPasswordNew,
    String? message,
  }) {
    return ProfileState(
      photoURL: photoURL ?? this.photoURL,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      viewState: viewState ?? this.viewState,
      isValidatePasswordOld:
          isValidatePasswordOld ?? this.isValidatePasswordOld,
      isShowPasswordOld: isShowPasswordOld ?? this.isShowPasswordOld,
      isShowPasswordNew: isShowPasswordNew ?? this.isShowPasswordNew,
      message: message ?? this.message,
    );
  }
}

// class ProfileState {
//   File photoURL;
//   ViewState viewState;
//   String? message;
//   ProfileState({required this.photoURL, required this.viewState, this.message});

//   factory ProfileState.initial() => ProfileState(
//       photoURL: File(''), viewState: ViewState.isNormal, message: null);
//   ProfileState update(
//       {File? photoURL, ViewState? viewState, String? message}) {
//     return ProfileState(
//         photoURL: photoURL ?? this.photoURL,
//         viewState: viewState ?? this.viewState,
//         message: message ?? this.message);
//   }
// }