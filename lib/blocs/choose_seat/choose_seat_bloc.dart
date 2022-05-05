import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/choose_seat/choose_seat_event.dart';
import 'package:movie_ticket/blocs/choose_seat/choose_seat_state.dart';
import 'package:movie_ticket/data/repositories/film_database.dart';
import 'package:movie_ticket/presentation/widgets/contants/contants.dart';

class ChooseSeatBloc extends Bloc<ChooseSeatEvent, ChooseSeatState> {
  FilmDatabase filmDatabase = FilmDatabase();
  ChooseSeatBloc()
      : super(
          ChooseSeatState(
            listSeatBooked: [],
            listSeatSelected: [],
          ),
        ) {
    on<ChooseSeatEvent>(
      (event, emit) async {
        if (event is StartedChooseSeatEvent) {
          final listTicketBooked = await filmDatabase.getAllTicket();
          List<String> listSeatBooked = [];
          for (var item in listTicketBooked) {
            if (item.cinemaName.compareTo(event.cinemaName.title) == 0 &&
                item.cinemaTime.compareTo(event.chooseTime.title) == 0 &&
                item.dateTime == event.chooseDate &&
                item.filmData.id == event.id
                ) {
              listSeatBooked.addAll(item.listSeat);
            }
          }
          emit.call(
            state.copyWith(listSeatBooked: listSeatBooked),
          );
        }
        if (event is SetSeatChooseSeatEvent) {
          if (state.listSeatSelected.contains(event.seat)) {
            final listSeatSelectedNew = state.listSeatSelected;
            listSeatSelectedNew.remove(event.seat);
            emit.call(
              state.copyWith(listSeatSelected: listSeatSelectedNew),
            );
          } else {
            final listSeatSelectedNew = state.listSeatSelected;
            listSeatSelectedNew.add(event.seat);
            emit.call(
              state.copyWith(listSeatSelected: listSeatSelectedNew),
            );
          }
        }
      },
    );
  }
}
