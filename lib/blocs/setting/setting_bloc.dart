import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/setting/setting_event.dart';
import 'package:movie_ticket/blocs/setting/setting_state.dart';
import 'package:movie_ticket/data/repositories/film_database.dart';
import 'package:movie_ticket/data/repositories/user_repository.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  UserRepository userRepository = UserRepository();
  FilmDatabase filmDatabase = FilmDatabase();
  SettingBloc() : super(SettingState.initial()) {
    on<SettingEvent>((event, emit) async {
      if (event is StartedSettingEvent) {
        var user = await userRepository.getCurrentUser();
        if (user != null) {
              final account = await filmDatabase.getAccount(uid: user.uid);
              emit.call(state.update(account: account));
            }
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
