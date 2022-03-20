import 'package:equatable/equatable.dart';
import 'package:movie_ticket/data/models/film_data.dart';

abstract class CartEvent extends Equatable {}

class StartedCartEvent extends CartEvent {
  @override
  List<Object?> get props => [];
}

class RefreshCartEvent extends CartEvent {
  @override
  List<Object?> get props => [];
}

class SelectCartEvent extends CartEvent {
  final FilmData filmData;
  final bool isSelected;
  SelectCartEvent({required this.filmData, required this.isSelected});
  @override
  List<Object?> get props => [filmData, isSelected];
}

class SelectAllCartEvent extends CartEvent {
  final bool isSelected;
  SelectAllCartEvent({
    required this.isSelected,
  });

  @override
  List<Object?> get props => [isSelected];
}

class DeleteCartEvent extends CartEvent {
  final int id;
  DeleteCartEvent({
    required this.id,
  });
  @override
  List<Object?> get props => [id];
}

class PaymentCartEvent extends CartEvent {
  final List<FilmData> listFilmData;
  PaymentCartEvent({
    required this.listFilmData,
  });

  @override
  List<Object?> get props => [listFilmData];
}
