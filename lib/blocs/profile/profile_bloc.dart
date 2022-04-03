import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_ticket/blocs/profile/profile_event.dart';
import 'package:movie_ticket/blocs/profile/profile_state.dart';
import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/data/repositories/user_repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  UserRepository userRepository = UserRepository();
  final ImagePicker _picker = ImagePicker();
  ProfileBloc() : super(ProfileState.initial()) {
    on<ProfileEvent>((event, emit) async {
      if (event is StartedProfileEvent) {
        emit.call(state.update(viewState: ViewState.isLoading));

        var currentUser = await userRepository.getCurrentUser();
        String? fullName = currentUser!.displayName;
        String? email = currentUser.email;
        String? photoURL = currentUser.photoURL;

        emit.call(state.update(
            viewState: ViewState.isSuccess,
            fullName: fullName,
            email: email,
            photoURL: photoURL));
        emit.call(state.update(viewState: ViewState.isNormal));
      }
      if (event is EditPhotoURLProfileEvent) {
        emit.call(state.update(viewState: ViewState.isLoading));
        try {
          final PickedFile? image = await _picker.getImage(
              source: ImageSource.gallery, maxWidth: 1800, maxHeight: 1800);
          if (image != null) {
            emit.call(state.update(
                viewState: ViewState.isSuccess,
                message: 'Pick Image Success',
                photoURL: image.path));

            emit.call(
                state.update(viewState: ViewState.isNormal, message: null));
          } else {
            emit.call(state.update(
                viewState: ViewState.isFailure,
                message: 'You don\'t pick image'));
            emit.call(
                state.update(viewState: ViewState.isNormal, message: null));
          }
        } catch (e) {
          emit.call(
              state.update(viewState: ViewState.isFailure, message: 'Error'));
          emit.call(state.update(viewState: ViewState.isNormal, message: null));
        }
      }
      if (event is EditUserProfileEvent) {
        emit.call(state.update(viewState: ViewState.isLoading));
        try {
          if (event.photoURL != null) {
            try {
              await userRepository.updateUser(photoURL: event.photoURL);
              emit.call(state.update(
                  viewState: ViewState.isSuccess,
                  message: 'Update photo is success'));
              emit.call(
                  state.update(viewState: ViewState.isNormal, message: null));
            } catch (e) {
              emit.call(state.update(
                  viewState: ViewState.isFailure,
                  message: 'Update photo is error'));
              emit.call(
                  state.update(viewState: ViewState.isNormal, message: null));
            }
          }
          if (event.displayName != '' && event.displayName != null) {
            await userRepository.updateUser(displayName: event.displayName);
          }
          if (event.passwordOld != '' && event.passwordOld != null) {}
        } catch (e) {
          emit.call(
              state.update(viewState: ViewState.isFailure, message: 'Error'));
          emit.call(state.update(viewState: ViewState.isNormal, message: null));
        }
      }
      if (event is ShowPasswordOldProfileEvent) {
        emit.call(state.update(isShowPasswordOld: event.isShowPassword));
      }
      if (event is ShowPasswordNewProfileEvent) {
        emit.call(state.update(isShowPasswordNew: event.isShowPassword));
      }
    });
  }
}
