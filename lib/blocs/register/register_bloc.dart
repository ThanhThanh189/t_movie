import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/register/register_event.dart';
import 'package:movie_ticket/blocs/register/register_state.dart';
import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/data/repositories/user_repository.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  UserRepository userRepository;
  RegisterBloc({required this.userRepository})
      : super(RegisterState.initial()) {
    on<RegisterEvent>((event, emit) async {
      if (event is SetEmailRegisterEvent) {
        emit.call(
            state.update(isValidateEmail: event.email == '' ? false : true));
      }
      if (event is SetPasswordRegisterEvent) {
        emit.call(state.update(
            isValidatePassword: event.password == '' ? false : true));
      }
      if (event is SetConfirmPasswordRegisterEvent) {
        emit.call(state.update(
            isValidateConfirmPassword: event.password == '' ? false : true));
      }
      if (event is ShowPasswordRegisterEvent) {
        emit.call(state.update(showPassword: event.showPassword));
      }
      if (event is ShowConfirmPasswordRegisterEvent) {
        emit.call(state.update(showConfirmPassword: event.showConfirmPassword));
      }
      if (event is RegisterWithEmailPasswordRegisterEvent) {
        if (event.email != '' &&
            event.password != '' &&
            event.confirmPassword != '') {
          if (event.password != event.confirmPassword) {
            emit.call(RegisterState.isFailure(
                message: 'Password and confirmPassword must be the same'));
            emit.call(RegisterState.initial());
          } else {
            try {
              emit.call(state.update(viewState: ViewState.isLoading));
              var user = await userRepository.createUserWithEmailPassword(
                  event.email, event.password);
              if (user != null) {
                emit.call(RegisterState.isSuccess(
                    user: user, message: 'Register success'));
                emit.call(RegisterState.initial());
              } else {
                emit.call(RegisterState.isFailure(message: 'Register failure'));
                emit.call(RegisterState.initial());
              }
            } catch (e) {
              emit.call(RegisterState.isFailure(message: 'Error'));
              emit.call(RegisterState.initial());
            }
          }
        } else {
          String message = 'Not be empty: ';
          if (event.email == '') message += 'email,';
          if (event.password == '') message += 'password,';
          if (event.confirmPassword == '') message += 'confirmPassword,';

          emit.call(RegisterState.isFailure(message: message));
          emit.call(RegisterState.initial());
        }
      }
    });
  }
}
