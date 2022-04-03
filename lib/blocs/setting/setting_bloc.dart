import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/setting/setting_event.dart';
import 'package:movie_ticket/blocs/setting/setting_state.dart';
import 'package:movie_ticket/data/repositories/user_repository.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  UserRepository userRepository = UserRepository();
  SettingBloc() : super(SettingState.initial()) {
    on<SettingEvent>((event, emit) async {
      if (event is StartedSettingEvent) {
        var user = await userRepository.getCurrentUser();
        emit.call(
          state.update(user: user),
        );
      }
      if (event is LoggedoutSettingEvent) {
        await userRepository.logOut();
      }
    });
  }
}
