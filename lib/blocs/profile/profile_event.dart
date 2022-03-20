import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {}

class StartedProfileEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}

class EditUserProfileEvent extends ProfileEvent {
  final String? photoURL;
  final String? displayName;
  final String? passwordOld;
  final String? passwordNew;
  EditUserProfileEvent(
      {this.photoURL, this.displayName, this.passwordOld, this.passwordNew});
  @override
  List<Object?> get props => [photoURL, displayName, passwordOld, passwordNew];
}

class EditPhotoURLProfileEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}

class ShowPasswordOldProfileEvent extends ProfileEvent {
  final bool isShowPassword;
  ShowPasswordOldProfileEvent({
    required this.isShowPassword,
  });
  @override
  List<Object?> get props => [isShowPassword];
}

class ShowPasswordNewProfileEvent extends ProfileEvent {
  final bool isShowPassword;
  ShowPasswordNewProfileEvent({
    required this.isShowPassword,
  });
  @override
  List<Object?> get props => [isShowPassword];
}
