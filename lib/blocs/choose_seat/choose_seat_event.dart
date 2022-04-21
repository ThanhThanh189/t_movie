import 'package:equatable/equatable.dart';

abstract class ChooseSeatEvent extends Equatable {}

class StartedChooseSeatEvent extends ChooseSeatEvent {
  @override
  List<Object?> get props => [];
}

class SetSeatChooseSeatEvent extends ChooseSeatEvent {
  final String seat;
  SetSeatChooseSeatEvent({
    required this.seat,
  });
  @override
  List<Object?> get props => [seat];
}
