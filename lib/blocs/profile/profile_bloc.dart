import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_ticket/blocs/profile/profile_event.dart';
import 'package:movie_ticket/blocs/profile/profile_state.dart';
import 'package:movie_ticket/common/app_strings.dart';
import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/data/repositories/user_repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  UserRepository userRepository = UserRepository();
  final ImagePicker _picker = ImagePicker();
  ProfileBloc() : super(ProfileState.initial()) {
    on<ProfileEvent>(
      (event, emit) async {
        if (event is StartedProfileEvent) {
          var currentUser = await userRepository.getCurrentUser();
          String? fullName = currentUser!.displayName;
          String? email = currentUser.email;
          String? photoURL = currentUser.photoURL;

          emit.call(state.update(
              fullNameOld: fullName, email: email, photoURLOld: photoURL));
          emit.call(state.update(viewState: ViewState.isNormal));
        }
        if (event is SetFullNameProfileEvent) {
          emit.call(
            state.update(
                isValidateFullName: event.fullName.isEmpty ? false : true),
          );
        }
        if (event is SetPasswordProfileEvent) {
          emit.call(
            state.update(
                isValidatePassword: event.password.isEmpty ? false : true),
          );
        }
        if (event is SetConfirmPasswordProfileEvent) {
          emit.call(
            state.update(
                isValidateConfirmPassword:
                    event.confirmPassword.isEmpty ? false : true),
          );
        }
        if (event is EditPhotoURLProfileEvent) {
          try {
            final PickedFile? image = await _picker.getImage(
                source: ImageSource.gallery, maxWidth: 1800, maxHeight: 1800);
            if (image != null) {
              emit.call(state.update(photoURLNew: image.path));
            }
          } catch (e) {
            emit.call(
              state.update(viewState: ViewState.isFailure, message: 'Error'),
            );
            emit.call(
              state.update(viewState: ViewState.isNormal, message: null),
            );
          }
        }
        if (event is EditUserProfileEvent) {
          emit.call(
            state.update(
                viewState: ViewState.isLoading,
                message: AppStrings.editProfileIsLoading),
          );
          try {
            if (event.newPassword.isNotEmpty &&
                event.confirmPassword.isNotEmpty) {
              if (event.newPassword != event.confirmPassword) {
                emit.call(
                  state.update(
                      viewState: ViewState.isFailure,
                      message: AppStrings.editProfilePasswordIsNotSame),
                );
                emit.call(
                  state.update(
                    viewState: ViewState.isNormal,
                    message: null,
                  ),
                );
              } else {
                try {
                  await userRepository.updatePassword(
                      password: event.newPassword);
                  emit.call(
                    state.update(
                        viewState: ViewState.isSuccess,
                        message: AppStrings.editProfilePasswordSuccess),
                  );
                  emit.call(
                    state.update(
                      viewState: ViewState.isNormal,
                      message: null,
                    ),
                  );
                } catch (_) {
                  emit.call(
                    state.update(
                        viewState: ViewState.isFailure,
                        message: AppStrings.editProfilePasswordFailure),
                  );
                  emit.call(
                    state.update(
                      viewState: ViewState.isNormal,
                      message: null,
                    ),
                  );
                }
              }
            }
            if (event.photoURL != null || event.displayName.isNotEmpty) {
              await userRepository.updateUser(
                photoURL: event.photoURL,
                displayName:
                    event.displayName.isNotEmpty ? event.displayName : null,
              );
              emit.call(
                state.update(
                    viewState: ViewState.isSuccess,
                    message: AppStrings.editProfileIsSuccess),
              );
              emit.call(
                state.update(
                  viewState: ViewState.isNormal,
                  message: null,
                ),
              );
            } else {
              emit.call(
                state.update(
                    viewState: ViewState.isFailure,
                    message: AppStrings.editProfileIsFailure),
              );
              emit.call(
                state.update(
                  viewState: ViewState.isNormal,
                  message: null,
                ),
              );
            }
          } catch (e) {
            emit.call(
              state.update(viewState: ViewState.isFailure, message: 'Error'),
            );
            emit.call(
              state.update(viewState: ViewState.isNormal, message: null),
            );
          }
        }
      },
    );
  }
}
