import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/login/login_event.dart';
import 'package:movie_ticket/blocs/login/login_state.dart';
import 'package:movie_ticket/common/app_strings.dart';
import 'package:movie_ticket/data/repositories/user_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository userRepository = UserRepository();
  LoginBloc() : super(LoginState.initial()) {
    on<LoginEvent>((event, emit) async {
      if (event is SetEmailLoginEvent) {
        emit.call(
            state.update(isValidateEmail: event.email!.isEmpty ? false : true));
      }
      if (event is SetPasswordLoginEvent) {
        emit.call(state.update(
            isValidatePassword: event.password!.isEmpty ? false : true));
      }
      if (event is LoginWithEmailAndPasswordEvent) {
        emit.call(LoginState.loading());
        if (event.email == AppStrings.userNameAdmin &&
            event.password == AppStrings.passwordAdmin) {
          emit.call(LoginState.success(isAdmin: true));
        } else {
          try {
            var user = await userRepository.signInWithEmailAndPassword(
                email: event.email, password: event.password);
            if (user != null) {
              emit.call(LoginState.success(user: user, isAdmin: false));
            } else {
              emit.call(
                  LoginState.failure(AppStrings.signinEmailAndPasswordError));
              emit.call(LoginState.initial());
            }
          } catch (_) {
            emit.call(LoginState.failure(AppStrings.signinIsFailure));
            emit.call(LoginState.initial());
          }
        }
      }
      if (event is ShowPasswordEvent) {
        emit.call(state.update(showPassword: event.showPassword));
      }
    });
  }
}
