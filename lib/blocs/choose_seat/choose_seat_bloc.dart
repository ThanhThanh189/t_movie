import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/choose_seat/choose_seat_event.dart';
import 'package:movie_ticket/blocs/choose_seat/choose_seat_state.dart';

class ChooseSeatBloc extends Bloc<ChooseSeatEvent, ChooseSeatState> {
  ChooseSeatBloc()
      : super(
          ChooseSeatState(
            listSeatBooked: ['A13', 'B15','A1','G1'],
            listSeatSelected: [],
          ),
        ) {
    on<ChooseSeatEvent>(
      (event, emit) async {
        if (event is StartedChooseSeatEvent) {}
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
