import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_ticket/blocs/register/register_event.dart';
import 'package:movie_ticket/blocs/register/register_state.dart';
import 'package:movie_ticket/common/app_strings.dart';
import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/data/models/account.dart';
import 'package:movie_ticket/data/repositories/film_database.dart';
import 'package:movie_ticket/data/repositories/user_repository.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  UserRepository userRepository = UserRepository();
  FilmDatabase filmDatabase = FilmDatabase();
  ImagePicker imagePicker = ImagePicker();
  RegisterBloc() : super(RegisterState.initial()) {
    on<RegisterEvent>(
      (event, emit) async {
        if (event is GetAvatarRegisterEvent) {
          if (!event.isExists) {
            final pickedFile = await imagePicker.getImage(
                source: ImageSource.gallery, maxWidth: 1800, maxHeight: 1800);
            final image = pickedFile?.path;
            emit.call(
              state.update(imageAvatar: image),
            );
          } else {
            emit.call(
              state.update(isRemoveImage: true),
            );
          }
        }
        if (event is SetFullNameRegisterEvent) {
          emit.call(state.update(
              isValidateFullName: event.fullName.isEmpty ? false : true));
        }
        if (event is SetEmailRegisterEvent) {
          emit.call(state.update(
              isValidateEmail: event.email.isEmpty ? false : true));
        }
        if (event is SetPasswordRegisterEvent) {
          emit.call(state.update(
              isValidatePassword: event.password.isEmpty ? false : true));
        }
        if (event is SetConfirmPasswordRegisterEvent) {
          emit.call(state.update(
              isValidateConfirmPassword:
                  event.password.isEmpty ? false : true));
        }
        if (event is ShowPasswordRegisterEvent) {
          emit.call(state.update(showPassword: event.showPassword));
        }
        if (event is ShowConfirmPasswordRegisterEvent) {
          emit.call(
              state.update(showConfirmPassword: event.showConfirmPassword));
        }
        if (event is RegisterWithEmailPasswordRegisterEvent) {
          debugPrint('display: ${event.displayName}');
          if (event.password != event.confirmPassword) {
            emit.call(
              state.update(
                viewState: ViewState.isFailure,
                message: AppStrings.signupPasswordIsNotSame,
              ),
            );
            emit.call(
              state.update(viewState: ViewState.isNormal),
            );
          } else {
            try {
              emit.call(
                state.update(
                  viewState: ViewState.isLoading,
                  message: AppStrings.signupIsLoading,
                ),
              );
              final emailIsExists = await userRepository
                  .fetchSignInMethodsForEmail(email: event.email);
              if (!emailIsExists) {
                var user = await userRepository.createUserWithEmailPassword(
                  email: event.email,
                  password: event.password,
                  displayName: event.displayName,
                  photoURL: state.imageAvatar,
                );
                debugPrint('USER: $user');
                if (user != null) {
                  final userNew = await userRepository.getCurrentUser();
                  if (userNew != null) {
                    await filmDatabase.addAndUpdateAccount(
                      uid: userNew.uid,
                      account: Account(
                        id: userNew.uid,
                        displayName: userNew.displayName,
                        photo: state.imageAvatar,
                        email: userNew.email,
                        wallet: 0,
                      ),
                    );
                  }
                  emit.call(
                    state.update(
                      user: user,
                      viewState: ViewState.isSuccess,
                      message: AppStrings.signupSignUpSuccess,
                    ),
                  );
                  emit.call(
                    state.update(viewState: ViewState.isNormal),
                  );
                } else {
                  emit.call(
                    state.update(
                      viewState: ViewState.isFailure,
                      message: AppStrings.signupSignUpFailure,
                    ),
                  );
                  emit.call(
                    state.update(viewState: ViewState.isNormal),
                  );
                }
              } else {
                emit.call(
                  state.update(
                    viewState: ViewState.isFailure,
                    message: AppStrings.signupEmailIsSignedUp,
                  ),
                );
                emit.call(
                  state.update(viewState: ViewState.isNormal),
                );
              }
            } catch (e) {
              emit.call(
                state.update(
                  viewState: ViewState.isFailure,
                  message: AppStrings.signupSignUpSuccess,
                ),
              );
              emit.call(
                state.update(viewState: ViewState.isNormal),
              );
            }
          }
        }
      },
    );
  }
}
