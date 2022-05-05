import 'package:equatable/equatable.dart';

abstract class MyTicketEvent extends Equatable {}

class StartedMyTicketEvent extends MyTicketEvent {
  @override
  List<Object?> get props => [];
}

class DeleteMyTicketEvent extends MyTicketEvent {
  final String id;
  DeleteMyTicketEvent({
    required this.id,
  });
  @override
  List<Object?> get props => [id];
}
