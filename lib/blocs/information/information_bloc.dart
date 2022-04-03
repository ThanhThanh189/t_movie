import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/information/information_event.dart';
import 'package:movie_ticket/blocs/information/information_state.dart';
import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/data/database/film_database.dart';
import 'package:movie_ticket/data/models/actor.dart';
import 'package:movie_ticket/data/models/film_data.dart';
import 'package:movie_ticket/data/models/review.dart';
import 'package:movie_ticket/data/repositories/film_repository.dart';

class InformationBloc extends Bloc<InformationEvent, InformationState> {
  FilmRepository filmRepository = FilmRepositoryImp();
  FilmDatabase filmDatabase = FilmDatabase.instance;
  InformationBloc()
      : super(InformationState.initial()) {
    on<InformationEvent>((event, emit) async {
      if (event is StartedInforEvent) {
        emit.call(state.update(viewState: ViewState.isLoading));
        try {
          var detail = await filmRepository.getDetail(event.id);
          var review = await filmRepository.getReview(event.id, 1);
          List<ReviewImp> reviews = [];
          if (review != null) {
            reviews = review.results;
          }
          var actor = await filmRepository.getActor(event.id);
          List<Cast> castAndCrew = [];
          if (actor != null) {
            castAndCrew.addAll(actor.cast);
            castAndCrew.addAll(actor.crew);
          }

          var similar = await filmRepository.getSimilar(event.id, 1);
          List<FilmData> similars = [];
          if (similar != null) {
            similars = similar.results;
          }

          bool checkIsFavorite = await filmDatabase.checkFavorite(event.id);

          bool checkIsInCart = await filmDatabase.checkCart(event.id);

          emit.call(state.update(
              detail: detail,
              reviews: reviews,
              casts: castAndCrew,
              similarMovies: similars,
              isFavorite: checkIsFavorite,
              isInCart: checkIsInCart,
              viewState: ViewState.isSuccess));
        } catch (e) {
          emit.call(state.update(
              viewState: ViewState.isFailure, message: 'Don\'t has data'));
          emit.call(state.update(viewState: ViewState.isNormal, message: ''));
        }
      }
      if (event is AddFavoriteInforEvent) {
        if (state.isFavorite == false) {
          try {
            emit.call(state.update(viewState: ViewState.isLoading));

            int id = await filmDatabase.addFilmsFavorite(event.filmData);
            if (id != 0) {
              emit.call(state.update(
                  viewState: ViewState.isSuccess,
                  message: 'Add favorite success',
                  isFavorite: true));
              emit.call(
                  state.update(viewState: ViewState.isNormal, message: ''));
            } else {
              emit.call(state.update(
                  viewState: ViewState.isFailure,
                  message: 'Add favorite failure'));
              emit.call(
                  state.update(viewState: ViewState.isNormal, message: ''));
            }
          } catch (e) {
            emit.call(
                state.update(viewState: ViewState.isFailure, message: 'Error'));
            emit.call(state.update(viewState: ViewState.isNormal, message: ''));
          }
        } else {
          emit.call(state.update(
              viewState: ViewState.isSuccess, message: 'Added to favorites'));
          emit.call(state.update(viewState: ViewState.isNormal, message: ''));
        }
      }

      if (event is AddCartInforEvent) {
        if (state.isInCart == false) {
          try {
            emit.call(state.update(viewState: ViewState.isLoading));

            int id = await filmDatabase.addFilmsCart(event.filmData);
            if (id != 0) {
              emit.call(state.update(
                viewState: ViewState.isSuccess,
                isInCart: true,
                message: 'Add in cart success',
              ));
              emit.call(
                  state.update(viewState: ViewState.isNormal, message: ''));
            } else {
              emit.call(state.update(
                  viewState: ViewState.isFailure,
                  message: 'Add in cart failure'));
              emit.call(
                  state.update(viewState: ViewState.isNormal, message: ''));
            }
          } catch (e) {
            emit.call(
                state.update(viewState: ViewState.isFailure, message: 'Error'));
            emit.call(state.update(viewState: ViewState.isNormal, message: ''));
          }
        } else {
          emit.call(state.update(
              viewState: ViewState.isSuccess, message: 'Added to cart'));
          emit.call(state.update(viewState: ViewState.isNormal, message: ''));
        }
      }
      if (event is IsReviewInforEvent) {
        emit.call(state.update(isReview: event.isReview));
      }
      if (event is ReadMoreOfSynopsisInforEvent) {
        emit.call(state.update(isReadMore: event.isReadMore));
      }
    });
  }
}
