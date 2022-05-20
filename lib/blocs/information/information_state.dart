import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/data/models/actor.dart';
import 'package:movie_ticket/data/models/detail.dart';
import 'package:movie_ticket/data/models/film_data.dart';
import 'package:movie_ticket/data/models/review.dart';

class InformationState {
  String? uid;
  Detail? detail;
  List<ReviewImp> reviews;
  List<Cast> casts;
  List<FilmData> similarMovies;
  List<FilmData> listFilmFavorite;

  String? infoVideo;
  String? trailerVideo;
  bool isReadMore;
  bool isReview;
  bool isFavorite;
  bool isInCart;
  ViewState viewState;
  String? message;
  InformationState({
    this.uid,
    this.detail,
    required this.reviews,
    required this.casts,
    required this.similarMovies,
    required this.listFilmFavorite,
    this.infoVideo,
    this.trailerVideo,
    required this.isReadMore,
    required this.isReview,
    required this.isFavorite,
    required this.isInCart,
    required this.viewState,
    this.message,
  });

  factory InformationState.initial() => InformationState(
        detail: null,
        reviews: [],
        casts: [],
        similarMovies: [],
        listFilmFavorite: [],
        isReadMore: true,
        isReview: false,
        isFavorite: false,
        isInCart: false,
        viewState: ViewState.isLoading,
      );

  InformationState update({
    String? uid,
    Detail? detail,
    List<ReviewImp>? reviews,
    List<Cast>? casts,
    List<FilmData>? similarMovies,
    List<FilmData>? listFilmFavorite,
    String? infoVideo,
    String? trailerVideo,
    bool? isReadMore,
    bool? isReview,
    bool? isFavorite,
    bool? isInCart,
    ViewState? viewState,
    String? message,
  }) {
    return InformationState(
        uid: uid ?? this.uid,
        detail: detail ?? this.detail,
        reviews: reviews ?? this.reviews,
        casts: casts ?? this.casts,
        similarMovies: similarMovies ?? this.similarMovies,
        listFilmFavorite: listFilmFavorite ?? this.listFilmFavorite,
        infoVideo: infoVideo ?? this.infoVideo,
        trailerVideo: trailerVideo,
        isReadMore: isReadMore ?? this.isReadMore,
        isReview: isReview ?? this.isReview,
        isFavorite: isFavorite ?? this.isFavorite,
        isInCart: isInCart ?? this.isInCart,
        viewState: viewState ?? this.viewState,
        message: message);
  }
}
