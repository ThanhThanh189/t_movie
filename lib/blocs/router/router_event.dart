import 'package:equatable/equatable.dart';

abstract class RouterEvent extends Equatable {}

class SelectItemRouterEvent extends RouterEvent {
  final int index;
  SelectItemRouterEvent({
    required this.index,
  });

  @override
  List<Object?> get props => [index];
}
