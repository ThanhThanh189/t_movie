import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {}

class AuthStartedEvent extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

class LoggedInEvent extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

class LoggedOutEvent extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}
