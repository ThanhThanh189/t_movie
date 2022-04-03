import 'package:equatable/equatable.dart';

abstract class SettingEvent extends Equatable {}

class StartedSettingEvent extends SettingEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class LoggedoutSettingEvent extends SettingEvent {
  @override
  List<Object?> get props => throw UnimplementedError();
}
