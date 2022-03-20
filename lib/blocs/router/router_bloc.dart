import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/router/router_event.dart';
import 'package:movie_ticket/blocs/router/router_state.dart';

class RouterBloc extends Bloc<RouterEvent, RouterState> {
  RouterBloc() : super(RouterState.initial()) {
    on<RouterEvent>((event, emit) async {
      if (event is SelectItemRouterEvent) {
        emit.call(state.update(index: event.index));
      }
    });
  }
}
