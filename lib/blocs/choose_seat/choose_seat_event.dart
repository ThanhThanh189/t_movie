import 'package:equatable/equatable.dart';

import 'package:movie_ticket/presentation/widgets/contants/contants.dart';

abstract class ChooseSeatEvent extends Equatable {}

class StartedChooseSeatEvent extends ChooseSeatEvent {
  final CinemaTime chooseTime;
  final DateTime chooseDate;
  final CinemaName cinemaName;
  final int id;
  StartedChooseSeatEvent({
    required this.id,
    required this.chooseTime,
    required this.chooseDate,
    required this.cinemaName,
  });
  @override
  List<Object?> get props => [id, chooseTime, chooseDate, cinemaName];
}

class SetSeatChooseSeatEvent extends ChooseSeatEvent {
  final String seat;
  SetSeatChooseSeatEvent({
    required this.seat,
  });
  @override
  List<Object?> get props => [seat];
}
