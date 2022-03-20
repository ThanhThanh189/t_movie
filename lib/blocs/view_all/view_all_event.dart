import 'package:equatable/equatable.dart';

abstract class ViewAllEvent extends Equatable {}

class StartedViewAllEvent extends ViewAllEvent {
  final String namePage;
  StartedViewAllEvent({
    required this.namePage,
  });
  @override
  List<Object?> get props => [namePage];
}

class LoadMoreViewAllEvent extends ViewAllEvent {
  final String namePage;
  final int numberPage;
  LoadMoreViewAllEvent({
    required this.namePage,
    required this.numberPage,
  });

  @override
  List<Object?> get props => [namePage, numberPage];
}
