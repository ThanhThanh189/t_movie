import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/revenue/revenue_event.dart';
import 'package:movie_ticket/blocs/revenue/revenue_state.dart';
import 'package:movie_ticket/data/models/ticket.dart';
import 'package:movie_ticket/data/repositories/film_database.dart';
import 'package:movie_ticket/presentation/widgets/contants/contants.dart';

class RevenueBloc extends Bloc<RevenueEvent, RevenueState> {
  FilmDatabase filmDatabase = FilmDatabase();
  RevenueBloc()
      : super(
          RevenueState(
            startDay: DateTime.now().subtract(const Duration(days: 7)),
            endDay: DateTime.now(),
            valueCinemaName: CinemaNameBox.all,
            valueCinemaTime: CinemaTimeBox.t0,
            listTicketNew: [],
            listAllTicket: [],
            total: 0,
          ),
        ) {
    on<RevenueEvent>(
      (event, emit) async {
        if (event is StartedRevenueEvent) {
          final listAllTicket = await filmDatabase.getAllRevenue();

          emit.call(state.copyWith(listAllTicket: listAllTicket));
          emit.call(
            state.copyWith(
              listTicketNew: _listTicketNew(
                startDay: state.startDay,
                endDay: state.endDay,
                listTicket: state.listAllTicket,
              ),
              total: getTotal(
                listTicket: _listTicketNew(
                  startDay: state.startDay,
                  endDay: state.endDay,
                  listTicket: state.listAllTicket,
                ),
              ),
            ),
          );
        }
        if (event is SetStartDayRevenueEvent) {
          if (event.startDay.compareTo(state.endDay) == 1) {
            emit.call(state.copyWith(
                startDay: event.startDay, endDay: event.startDay));
          }
          emit.call(state.copyWith(startDay: event.startDay));

          emit.call(
            state.copyWith(
              listTicketNew: _listTicketNew(
                startDay: state.startDay,
                endDay: state.endDay,
                listTicket: state.listAllTicket,
                cinemaNameBox: state.valueCinemaName,
                cinemaTimeBox: state.valueCinemaTime,
              ),
              total: getTotal(
                listTicket: _listTicketNew(
                  startDay: state.startDay,
                  endDay: state.endDay,
                  listTicket: state.listAllTicket,
                  cinemaNameBox: state.valueCinemaName,
                  cinemaTimeBox: state.valueCinemaTime,
                ),
              ),
            ),
          );
        }
        if (event is SetEndDayRevenueEvent) {
          if (event.endDay.compareTo(state.startDay) == -1) {
            emit.call(
                state.copyWith(startDay: event.endDay, endDay: event.endDay));
          }
          emit.call(state.copyWith(endDay: event.endDay));
          emit.call(
            state.copyWith(
              listTicketNew: _listTicketNew(
                startDay: state.startDay,
                endDay: state.endDay,
                listTicket: state.listAllTicket,
                cinemaNameBox: state.valueCinemaName,
                cinemaTimeBox: state.valueCinemaTime,
              ),
              total: getTotal(
                listTicket: _listTicketNew(
                  startDay: state.startDay,
                  endDay: state.endDay,
                  listTicket: state.listAllTicket,
                  cinemaNameBox: state.valueCinemaName,
                  cinemaTimeBox: state.valueCinemaTime,
                ),
              ),
            ),
          );
        }
        if (event is SetCinemaTimeRevenueEvent) {
          emit.call(state.copyWith(
            valueCinemaTime: event.cinemaTimeBox,
            listTicketNew: _listTicketNew(
              startDay: state.startDay,
              endDay: state.endDay,
              listTicket: state.listAllTicket,
              cinemaTimeBox: event.cinemaTimeBox,
              cinemaNameBox: state.valueCinemaName,
            ),
            total: getTotal(
              listTicket: _listTicketNew(
                startDay: state.startDay,
                endDay: state.endDay,
                listTicket: state.listAllTicket,
                cinemaTimeBox: event.cinemaTimeBox,
                cinemaNameBox: state.valueCinemaName,
              ),
            ),
          ));
        }
        if (event is SetCinemaNameRevenueEvent) {
          emit.call(state.copyWith(
            valueCinemaName: event.cinemaNameBox,
            listTicketNew: _listTicketNew(
              startDay: state.startDay,
              endDay: state.endDay,
              listTicket: state.listAllTicket,
              cinemaNameBox: event.cinemaNameBox,
              cinemaTimeBox: state.valueCinemaTime,
            ),
            total: getTotal(
              listTicket: _listTicketNew(
                startDay: state.startDay,
                endDay: state.endDay,
                listTicket: state.listAllTicket,
                cinemaNameBox: event.cinemaNameBox,
                cinemaTimeBox: state.valueCinemaTime,
              ),
            ),
          ));
        }
      },
    );
  }
}

List<Ticket> _listTicketNew({
  required DateTime startDay,
  required DateTime endDay,
  CinemaTimeBox? cinemaTimeBox,
  CinemaNameBox? cinemaNameBox,
  required List<Ticket> listTicket,
}) {
  List<Ticket> listTicketByDate = [];
  for (var item in listTicket) {
    if (item.dateCreate.compareTo(
              DateTime(
                startDay.year,
                startDay.month,
                startDay.day - 1,
              ),
            ) ==
            1 &&
        item.dateCreate.compareTo(
              DateTime(
                endDay.year,
                endDay.month,
                endDay.day + 1,
              ),
            ) ==
            -1) {
      listTicketByDate.add(item);
    }
  }
  var toRemove = [];
  for (var item in listTicketByDate) {
    if (cinemaNameBox != null && cinemaNameBox != CinemaNameBox.all) {
      if (cinemaNameBox.title != item.cinemaName) {
        toRemove.add(item);
      }
    }
  }

  for (var item in listTicketByDate) {
    if (cinemaTimeBox != null && cinemaTimeBox != CinemaTimeBox.t0) {
      if (cinemaTimeBox.title != item.cinemaTime) {
        toRemove.add(item);
      }
    }
  }
  listTicketByDate.removeWhere((element) => toRemove.contains(element));
  return listTicketByDate;
}

int getTotal({required List<Ticket> listTicket}) {
  int total = 0;
  for (var element in listTicket) {
    total += element.total;
  }
  return total;
}
