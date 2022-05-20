import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/cinema_and_date/cinema_and_date_event.dart';
import 'package:movie_ticket/blocs/cinema_and_date/cinema_and_date_state.dart';
import 'package:movie_ticket/common/date_contants.dart';
import 'package:movie_ticket/presentation/widgets/contants/contants.dart';

class CinemaAndDateBloc extends Bloc<CinemaAndDateEvent, CinemaAndDateState> {
  CinemaAndDateBloc()
      : super(CinemaAndDateState(
          listDateTime: [],
          cinemaName: CinemaName.centralParkCGV,
        )) {
    on<CinemaAndDateEvent>(
      (event, emit) async {
        if (event is StartedCinemaAndDateEvent) {
          List<DateTime> listDateTime =
              DateTime.now().getListNumberDate(numberDate: 7);
          emit.call(state.copyWith(listDateTime: listDateTime));
        }
        if (event is SetDayCinemaAndDateEvent) {
          emit.call(state.copyWith(day: event.chooseDay));
        }
        if (event is SetTimeCinemaAndDateEvent) {
          // print('cinemaName: ${event.cinemaName}');
          emit.call(
            state.copyWith(time: event.time, cinemaName: event.cinemaName),
          );
        }
      },
    );
  }
}
