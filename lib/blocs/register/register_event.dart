import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {}

class SetEmailRegisterEvent extends RegisterEvent {
  final String email;
  SetEmailRegisterEvent({
    required this.email,
  });
  @override
  List<Object?> get props => [email];
}

class SetPasswordRegisterEvent extends RegisterEvent {
  final String password;
  SetPasswordRegisterEvent({
    required this.password,
  });
  @override
  List<Object?> get props => [password];
}

class SetConfirmPasswordRegisterEvent extends RegisterEvent {
  final String password;
  SetConfirmPasswordRegisterEvent({
    required this.password,
  });
  @override
  List<Object?> get props => [password];
}

class ShowPasswordRegisterEvent extends RegisterEvent {
  final bool showPassword;
  ShowPasswordRegisterEvent({
    required this.showPassword,
  });
  @override
  List<Object?> get props => [showPassword];
}

class ShowConfirmPasswordRegisterEvent extends RegisterEvent {
  final bool showConfirmPassword;
  ShowConfirmPasswordRegisterEvent({
    required this.showConfirmPassword,
  });
  @override
  List<Object?> get props => [showConfirmPassword];
}

class RegisterWithEmailPasswordRegisterEvent extends RegisterEvent {
  final String email;
  final String password;
  final String confirmPassword;
  RegisterWithEmailPasswordRegisterEvent({
    required this.email,
    required this.password,
    required this.confirmPassword,
  });
  @override
  List<Object?> get props => [email, password, confirmPassword];
}
