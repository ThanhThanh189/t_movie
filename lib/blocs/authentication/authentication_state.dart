import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class AuthStateInitial extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthStateLoading extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthStateSuccess extends AuthenticationState {
  final User user;
  AuthStateSuccess({
    required this.user,
  });
  @override
  List<Object?> get props => [user];
}

class AuthStateFailure extends AuthenticationState {
  @override
  List<Object?> get props => [];
}
