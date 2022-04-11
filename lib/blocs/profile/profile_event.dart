import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {}

class StartedProfileEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}

class SetFullNameProfileEvent extends ProfileEvent {
  final String fullName;

  SetFullNameProfileEvent({required this.fullName});
  @override
  List<Object?> get props => [fullName];
}

class SetPasswordProfileEvent extends ProfileEvent {
  final String password;

  SetPasswordProfileEvent({required this.password});
  @override
  List<Object?> get props => [password];
}

class SetConfirmPasswordProfileEvent extends ProfileEvent {
  final String confirmPassword;

  SetConfirmPasswordProfileEvent({required this.confirmPassword});
  @override
  List<Object?> get props => [confirmPassword];
}

class EditUserProfileEvent extends ProfileEvent {
  final String? photoURL;
  final String displayName;
  final String newPassword;
  final String confirmPassword;
  EditUserProfileEvent(
      {this.photoURL,
      required this.displayName,
      required this.newPassword,
      required this.confirmPassword});
  @override
  List<Object?> get props =>
      [photoURL, displayName, newPassword, confirmPassword];
}

class EditPhotoURLProfileEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}
