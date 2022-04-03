import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/search/search_event.dart';
import 'package:movie_ticket/blocs/search/search_state.dart';
import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/data/repositories/film_repository.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  FilmRepository filmRepository = FilmRepositoryImp();
  SearchBloc() : super(SearchState.initial()) {
    on<SearchEvent>((event, emit) async {
      if (event is StartedSearchEvent) {
        // emit.call(state.update(viewState: ViewState.isLoading));
      }
      if (event is SearchByNameSearchEvent) {
        if (event.nameFilm != '') {
          emit.call(state.update(viewState: ViewState.isLoading));
          try {
            var listFilmData =
                await filmRepository.getListFilmByName(event.nameFilm, 1);
            if (listFilmData!.isNotEmpty) {
              emit.call(state.update(
                  viewState: ViewState.isSuccess, listFilmData: listFilmData));
            } else {
              emit.call(state.update(
                  viewState: ViewState.isFailure, message: 'Don\'t find film'));
            }
          } catch (_) {
            emit.call(
                state.update(viewState: ViewState.isFailure, message: 'Error'));
            emit.call(SearchState.initial());
          }
        } else {
          emit.call(SearchState.initial());
        }
      }
      if (event is ClearSearchEvent) {
        emit.call(SearchState.initial());
      }
    });
  }
}
