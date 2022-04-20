import 'package:equatable/equatable.dart';

import 'package:movie_ticket/presentation/widgets/contants/contants.dart';

abstract class CinemaAndDateEvent extends Equatable {}

class StartedCinemaAndDateEvent extends CinemaAndDateEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class SetDayCinemaAndDateEvent extends CinemaAndDateEvent {
  final DateTime chooseDay;
  SetDayCinemaAndDateEvent({
    required this.chooseDay,
  });
  @override
  List<Object?> get props => [chooseDay];
}

class SetTimeCinemaAndDateEvent extends CinemaAndDateEvent {
  final CinemaTime time;
  final CinemaName cinemaName;
  SetTimeCinemaAndDateEvent({
    required this.time,
    required this.cinemaName,
  });
  @override
  List<Object?> get props => [time, cinemaName];
}
