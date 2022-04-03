import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/view_all/view_all_event.dart';
import 'package:movie_ticket/blocs/view_all/view_all_state.dart';
import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/data/models/film_data.dart';
import 'package:movie_ticket/data/repositories/film_repository.dart';

class ViewAllBloc extends Bloc<ViewAllEvent, ViewAllState> {
  FilmRepository filmRepository = FilmRepositoryImp();
  ViewAllBloc()
      : super(ViewAllState(
            listFilmData: [],
            viewState: ViewState.isNormal,
            isSelectLoadMore: false,
            isLastPage: false,
            pageCurrent: 1,
            message: '')) {
    on<ViewAllEvent>((event, emit) async {
      if (event is StartedViewAllEvent) {
        emit.call(state.update(viewState: ViewState.isLoading));
        try {
          var listFilmData =
              await filmRepository.getListFilm(event.namePage, 1);
          emit.call(state.update(
              listFilmData: listFilmData!.isNotEmpty ? listFilmData : [],
              viewState: listFilmData.isNotEmpty
                  ? ViewState.isSuccess
                  : ViewState.isFailure,
              message: listFilmData.isNotEmpty ? 'success' : 'failure'));
          emit.call(state.update(viewState: ViewState.isNormal, message: ''));
        } catch (_) {
          emit.call(state.update(
              viewState: ViewState.isFailure, message: 'Don\'t has data'));
          emit.call(state.update(viewState: ViewState.isNormal, message: ''));
        }
      }
      if (event is LoadMoreViewAllEvent) {
        emit.call(state.update(isSelectLoadMore: true));
        try {
          if (event.numberPage <= 500) {
            var listFilmDataNew = await filmRepository.getListFilm(
                event.namePage, event.numberPage);
            List<FilmData> listFilmData = state.listFilmData;
            if (listFilmDataNew!.isNotEmpty) {
              listFilmData.addAll(listFilmDataNew);
            }
            emit.call(state.update(
                listFilmData: listFilmData,
                isSelectLoadMore: false,
                pageCurrent: event.numberPage));
          } else {
            emit.call(state.update(isSelectLoadMore: false, isLastPage: true));
          }
        } catch (_) {
          emit.call(state.update(
              isSelectLoadMore: false, pageCurrent: event.numberPage));
        }
      }
    });
  }
}
