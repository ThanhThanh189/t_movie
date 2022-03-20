import 'package:equatable/equatable.dart';
import 'package:movie_ticket/data/models/film_data.dart';

abstract class InformationEvent extends Equatable {}

class StartedInforEvent extends InformationEvent {
  final int id;
  StartedInforEvent({
    required this.id,
  });
  @override
  List<Object?> get props => [id];
}

class AddFavoriteInforEvent extends InformationEvent {
  final FilmData filmData;
  AddFavoriteInforEvent({
    required this.filmData,
  });
  @override
  List<Object?> get props => [filmData];
}

class AddCartInforEvent extends InformationEvent {
  final FilmData filmData;
  AddCartInforEvent({
    required this.filmData,
  });
  @override
  List<Object?> get props => [filmData];
}

class IsReviewInforEvent extends InformationEvent {
  final bool isReview;
  IsReviewInforEvent({
    required this.isReview,
  });
  @override
  List<Object?> get props => [isReview];
}

class ReadMoreOfSynopsisInforEvent extends InformationEvent {
  final bool isReadMore;
  ReadMoreOfSynopsisInforEvent({
    required this.isReadMore,
  });
  @override
  List<Object?> get props => [isReadMore];
}
