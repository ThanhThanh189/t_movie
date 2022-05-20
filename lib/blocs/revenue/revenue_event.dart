import 'package:equatable/equatable.dart';

import 'package:movie_ticket/presentation/widgets/contants/contants.dart';

abstract class RevenueEvent extends Equatable {}

class StartedRevenueEvent extends RevenueEvent {
  @override
  List<Object?> get props => [];
}

class SetStartDayRevenueEvent extends RevenueEvent {
  final DateTime startDay;
  SetStartDayRevenueEvent({
    required this.startDay,
  });
  @override
  List<Object?> get props => [startDay];
}

class SetEndDayRevenueEvent extends RevenueEvent {
  final DateTime endDay;
  SetEndDayRevenueEvent({
    required this.endDay,
  });
  @override
  List<Object?> get props => [endDay];
}

class SetCinemaTimeRevenueEvent extends RevenueEvent {
  final CinemaTimeBox cinemaTimeBox;
  SetCinemaTimeRevenueEvent({
    required this.cinemaTimeBox,
  });
  @override
  List<Object?> get props => [cinemaTimeBox];
}

class SetCinemaNameRevenueEvent extends RevenueEvent {
  final CinemaNameBox cinemaNameBox;
  SetCinemaNameRevenueEvent({
    required this.cinemaNameBox,
  });
  @override
  List<Object?> get props => [cinemaNameBox];
}
