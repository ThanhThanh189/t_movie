import 'package:equatable/equatable.dart';

abstract class FavoriteEvent extends Equatable {}

class StartedFavoriteEvent extends FavoriteEvent {
  @override
  List<Object?> get props => [];
}

class RefreshFavoriteEvent extends FavoriteEvent {
  @override
  List<Object?> get props => [];
}

class DeleteFavoriteEvent extends FavoriteEvent {
  final int id;
  DeleteFavoriteEvent({
    required this.id,
  });
  @override
  List<Object?> get props => [id];
}
