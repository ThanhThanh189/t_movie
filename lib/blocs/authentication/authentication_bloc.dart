import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/authentication/authentication_event.dart';
import 'package:movie_ticket/blocs/authentication/authentication_state.dart';
import 'package:movie_ticket/data/repositories/user_repository.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  UserRepository userRepository  = UserRepository(); 
  AuthenticationBloc() : super(AuthStateInitial()) {
    on<AuthenticationEvent>((event, emit) async {
      if (event is AuthStartedEvent) {
        emit.call(AuthStateLoading());
        try {
          var isLoggedIn = await userRepository.isSignedIn();
          if (isLoggedIn) {
            var user = await userRepository.getCurrentUser();
            if (user != null) {
              emit.call(AuthStateSuccess(user: user));
            }
          } else {
            emit.call(AuthStateFailure());
          }
        } catch (_) {
          emit.call(AuthStateFailure());
        }
      }
      if (event is LoggedInEvent) {
        var user = await userRepository.getCurrentUser();
        try {
          if (user != null) {
            emit.call(AuthStateSuccess(user: user));
          } else {
            emit.call(AuthStateFailure());
          }
        } catch (_) {
          emit.call(AuthStateFailure());
        }
      }

      if (event is LoggedOutEvent) {
        await userRepository.logOut();
        emit.call(AuthStateFailure());
      }
    });
  }
}
