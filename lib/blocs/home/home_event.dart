import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {}

class StartedHomeEvent extends HomeEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}
