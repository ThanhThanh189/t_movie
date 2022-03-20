import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/login/login_event.dart';
import 'package:movie_ticket/blocs/login/login_state.dart';
import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/data/repositories/user_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository userRepository;
  LoginBloc({required this.userRepository}) : super(LoginState.initial()) {
    on<LoginEvent>((event, emit) async {
      if (event is SetEmailLoginEvent) {
        emit.call(
            state.update(isValidateEmail: event.email == '' ? false : true));
      }
      if (event is SetPasswordLoginEvent) {
        emit.call(state.update(
            isValidatePassword: event.password == '' ? false : true));
      }
      if (event is LoginWithEmailAndPasswordEvent) {
        if (event.email != '' && event.password != '') {
          emit.call(LoginState.loading());
          try {
            var user = await userRepository.signInWithEmailAndPassword(
                email: event.email, password: event.password);
            if (user != null) {
              emit.call(LoginState.success(user: user));
            } else {
              emit.call(LoginState.failure('Email or Password is not correct'));
              emit.call(LoginState.initial());
            }
          } catch (_) {
            emit.call(LoginState.failure('Login is failure'));
            emit.call(LoginState.initial());
          }
        } else {
          // emit.call(LoginState.failure('Email or Password is not empty'));
          // emit.call(LoginState.initial());
          emit.call(state.update(
              viewState: ViewState.isFailure,
              message: 'Email or Password is not empty'));
          emit.call(state.update(viewState: ViewState.isNormal, message: null));
        }
      }
      if (event is ShowPasswordEvent) {
        emit.call(state.update(showPassword: event.showPassword));
      }
    });
  }
}
