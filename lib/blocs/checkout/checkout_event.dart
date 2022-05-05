import 'package:equatable/equatable.dart';

import 'package:movie_ticket/data/models/ticket.dart';

abstract class CheckoutEvent extends Equatable {}

class StartedCheckoutEvent extends CheckoutEvent {
  @override
  List<Object?> get props => [];
}

class SelectCheckoutEvent extends CheckoutEvent {
  final Ticket ticket;
  SelectCheckoutEvent({
    required this.ticket,
  });
  @override
  List<Object?> get props => [ticket];
}
