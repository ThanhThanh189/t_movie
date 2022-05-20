import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_ticket/blocs/profile/profile_event.dart';
import 'package:movie_ticket/blocs/profile/profile_state.dart';
import 'package:movie_ticket/common/app_strings.dart';
import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/data/models/account.dart';
import 'package:movie_ticket/data/repositories/film_database.dart';
import 'package:movie_ticket/data/repositories/user_repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  UserRepository userRepository = UserRepository();
  FilmDatabase filmDatabase = FilmDatabase();
  final ImagePicker _picker = ImagePicker();
  ProfileBloc() : super(ProfileState.initial()) {
    on<ProfileEvent>(
      (event, emit) async {
        if (event is StartedProfileEvent) {
          var currentUser = await userRepository.getCurrentUser();
          Account? account;
          if (currentUser != null) {
            account = await filmDatabase.getAccount(uid: currentUser.uid);
          }
          String? fullName = currentUser!.displayName;
          String? email = currentUser.email;
          String? photoURL = currentUser.photoURL;

          emit.call(
            state.update(
              uid: currentUser.uid,
              fullName: fullName,
              email: email,
              photoURLOld: photoURL ?? account?.photo,
            ),
          );
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
            if (event.photoURL != null || event.displayName.isNotEmpty) {
              await userRepository.updateUser(
                photoURL: event.photoURL,
                displayName:
                    event.displayName.isNotEmpty ? event.displayName : null,
              );
              if (state.uid != null) {
                final account =
                    await filmDatabase.getAccount(uid: state.uid ?? '');
                await filmDatabase.addAndUpdateAccount(
                    uid: state.uid ?? '',
                    account: Account(
                        id: account?.id,
                        photo: event.photoURL ?? account?.photo,
                        displayName: event.displayName.isNotEmpty
                            ? event.displayName
                            : state.fullName,
                        email: state.email,
                        wallet: account?.wallet));
              }
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
