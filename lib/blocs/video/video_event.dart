import 'package:equatable/equatable.dart';

abstract class VideoEvent extends Equatable {}

class StartedVideoEvent extends VideoEvent {
  final int id;

  StartedVideoEvent({required this.id});
  @override
  List<Object?> get props => [id];
}
