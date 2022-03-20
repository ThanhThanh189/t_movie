import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {}

class StartedSearchEvent extends SearchEvent {
  @override
  List<Object?> get props => [];
}

class SearchByNameSearchEvent extends SearchEvent {
  final String nameFilm;
  SearchByNameSearchEvent({
    required this.nameFilm,
  });
  @override
  List<Object?> get props => [nameFilm];
}

class ClearSearchEvent extends SearchEvent {
  @override
  List<Object?> get props => [];
}
