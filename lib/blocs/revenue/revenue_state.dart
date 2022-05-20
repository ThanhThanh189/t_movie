import 'package:movie_ticket/data/models/ticket.dart';
import 'package:movie_ticket/presentation/widgets/contants/contants.dart';

class RevenueState {
  DateTime startDay;
  DateTime endDay;
  CinemaTimeBox valueCinemaTime;
  CinemaNameBox valueCinemaName;
  List<Ticket> listAllTicket;
  List<Ticket> listTicketNew;
  int total;
  RevenueState({
    required this.startDay,
    required this.endDay,
    required this.valueCinemaTime,
    required this.valueCinemaName,
    required this.listAllTicket,
    required this.listTicketNew,
    required this.total,
  });

  RevenueState copyWith({
    DateTime? startDay,
    DateTime? endDay,
    CinemaTimeBox? valueCinemaTime,
    CinemaNameBox? valueCinemaName,
    List<Ticket>? listAllTicket,
    List<Ticket>? listTicketNew,
    int? total,
  }) {
    return RevenueState(
      startDay: startDay ?? this.startDay,
      endDay: endDay ?? this.endDay,
      valueCinemaTime: valueCinemaTime ?? this.valueCinemaTime,
      valueCinemaName: valueCinemaName ?? this.valueCinemaName,
      listAllTicket: listAllTicket ?? this.listAllTicket,
      listTicketNew: listTicketNew ?? this.listTicketNew,
      total: total ?? this.total,
    );
  }
}
