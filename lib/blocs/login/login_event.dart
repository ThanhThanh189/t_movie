import 'package:equatable/equatable.dart';

class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SetEmailLoginEvent extends LoginEvent {
  final String? email;
  SetEmailLoginEvent({
    this.email,
  });
  @override
  List<Object?> get props => [email];
}

class SetPasswordLoginEvent extends LoginEvent {
  final String? password;
  SetPasswordLoginEvent({
    this.password,
  });
  @override
  List<Object?> get props => [password];
}

class LoginWithEmailAndPasswordEvent extends LoginEvent {
  final String email;
  final String password;
  LoginWithEmailAndPasswordEvent({
    required this.email,
    required this.password,
  });
  @override
  List<Object?> get props => [email, password];
}

class ShowPasswordEvent extends LoginEvent {
  final bool showPassword;
  ShowPasswordEvent({
    required this.showPassword,
  });
  @override
  List<Object?> get props => [showPassword];
}
