import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:movie_ticket/blocs/information/information_bloc.dart';
import 'package:movie_ticket/blocs/information/information_event.dart';
import 'package:movie_ticket/blocs/information/information_state.dart';
import 'package:movie_ticket/common/global.dart';
import 'package:movie_ticket/common/string_constraints.dart';
import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/data/models/film_data.dart';
import 'package:movie_ticket/data/models/review.dart';
import 'package:movie_ticket/data/repositories/film_repository.dart';

// details: https://api.themoviedb.org/3/movie/634649?api_key=0cae59a37fef24193f04010b16b61e8e&language=en-US
// reviews: https://api.themoviedb.org/3/movie/634649/reviews?api_key=0cae59a37fef24193f04010b16b61e8e&language=en-US&page=1
// actor: https://api.themoviedb.org/3/movie/634649/credits?api_key=0cae59a37fef24193f04010b16b61e8e&language=en-US
// similar: https://api.themoviedb.org/3/movie/634649/similar?api_key=0cae59a37fef24193f04010b16b61e8e&language=en-US&page=1

class InformationScreen extends StatelessWidget {
  final FilmRepository filmRepository;
  final FilmData filmData;
  const InformationScreen(
      {Key? key, required this.filmRepository, required this.filmData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InformationBloc>(
      create: (context) => InformationBloc(filmRepository: filmRepository)
        ..add(StartedInforEvent(id: filmData.id)),
      child: BlocConsumer<InformationBloc, InformationState>(
        listener: (context, state) {
          if (state.viewState == ViewState.isFailure) {
            state.message != '' && state.message != null
                ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.message.toString()),
                    duration: const Duration(milliseconds: 1000),
                  ))
                : null;
          }
          if (state.viewState == ViewState.isSuccess) {
            state.message != '' && state.message != null
                ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.message.toString()),
                    duration: const Duration(milliseconds: 1000)))
                : null;
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoImage(context, state),
                    _buildAboutMovie(context, state),
                    _buildListCastAndCrew(context, state),
                    _buildTrailerAndSong(context, state),
                  ],
                ),
              ),
              floatingActionButton: _buildAddToCart(context, state),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoImage(BuildContext context, InformationState state) {
    String genres = '';
    if (state.detail != null) {
      for (var item in state.detail!.genres) {
        genres += '${item.name}, ';
      }
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              child: state.detail != null
                  ? _buildLoadImage(
                      url: Global.imageURL + state.detail!.backdropPath)
                  : _buildImageDefault(url: 'assets/images/loading_dark.gif')),
          Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios, size: 30))),
          Positioned(
            right: 10,
            top: 10,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: GestureDetector(
                onTap: () {
                  BlocProvider.of<InformationBloc>(context)
                      .add(AddFavoriteInforEvent(filmData: filmData));
                },
                child: Icon(
                  Icons.favorite,
                  color: state.isFavorite ? Colors.pink : Colors.grey,
                  size: 30,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.detail != null ? state.detail!.originalTitle : '',
                  maxLines: 2,
                  style: StringConstraints.h2Bold,
                ),
                Row(
                  children: [
                    RatingBar.builder(
                        initialRating: state.detail != null
                            ? state.detail!.voteAverage / 2.0
                            : 5,
                        minRating: 1,
                        itemCount: 5,
                        itemSize: 15,
                        tapOnlyMode: true,
                        allowHalfRating: true,
                        itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                        onRatingUpdate: (rating) {}),
                    Text(
                      '(${state.detail != null ? state.detail!.voteAverage / 2.0 : 5})',
                    )
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    genres,
                    style: StringConstraints.h7,
                  ),
                ),
                Text(
                  state.detail != null
                      ? DateFormat('dd-MM-yyyy')
                          .format(state.detail!.releaseDate)
                      : '',
                  style: StringConstraints.h7,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutMovie(BuildContext context, InformationState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(40, 20, 40, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: !state.isReview
                        ? const Border(
                            bottom: BorderSide(color: Colors.white, width: 1.0))
                        : null),
                child: GestureDetector(
                  onTap: () {
                    BlocProvider.of<InformationBloc>(context)
                        .add(IsReviewInforEvent(isReview: false));
                  },
                  child: Text(
                    'About Movie',
                    style: state.isReview
                        ? StringConstraints.h8
                        : StringConstraints.h8Bold,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: state.isReview
                        ? const Border(
                            bottom: BorderSide(color: Colors.white, width: 1.0))
                        : null),
                child: GestureDetector(
                    onTap: () {
                      BlocProvider.of<InformationBloc>(context)
                          .add(IsReviewInforEvent(isReview: true));
                    },
                    child: Text('Review',
                        style: !state.isReview
                            ? StringConstraints.h8
                            : StringConstraints.h8Bold)),
              ),
            ],
          ),
        ),
        state.isReview
            ? _buildReviewFilm(context, state)
            : _buildSynopsis(context, state)
      ],
    );
  }

  Widget _buildListCastAndCrew(BuildContext context, InformationState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10, left: 10),
          child: const Text('Cast & Crew',
              style: StringConstraints.h2Bold, textAlign: TextAlign.start),
        ),
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.15,
          child: Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.casts.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: Column(children: [
                      Expanded(
                          child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: state.casts[index].profilePath != null
                            ? Image.network(
                                Global.imageURL +
                                    state.casts[index].profilePath.toString(),
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Image.asset(
                                    'assets/images/loading_dark.gif',
                                    fit: BoxFit.cover,
                                  );
                                },
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  if (stackTrace != null) {
                                    return const Center(
                                        child: Icon(Icons.error));
                                  }
                                  return const Center(child: Icon(Icons.error));
                                },
                              )
                            : Image.asset('assets/images/no_avatar.png'),
                      )),
                      Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Text(
                            state.casts[index].originalName,
                            style: StringConstraints.h7,
                            textAlign: TextAlign.center,
                          ))
                    ]),
                  );
                }),
          ),
        )
      ],
    );
  }

  Widget _buildTrailerAndSong(BuildContext context, InformationState state) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10, left: 10),
            child: const Text('Trailer and song',
                style: StringConstraints.h2Bold, textAlign: TextAlign.start),
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context, builder: (_) => _builDialog(context));
            },
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.20,
              child: Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.similarMovies.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Stack(children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: state.similarMovies[index].backdropPath !=
                                      null
                                  ? Image.network(
                                      Global.imageURL +
                                          state.similarMovies[index]
                                              .backdropPath!
                                              .toString(),
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Image.asset(
                                          'assets/images/loading_dark.gif',
                                          fit: BoxFit.cover,
                                        );
                                      },
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        if (stackTrace != null) {
                                          return const Center(
                                              child: Icon(Icons.error));
                                        }
                                        return const Center(
                                            child: Icon(Icons.error));
                                      },
                                    )
                                  : Image.network(
                                      Global.imageURL +
                                          state.similarMovies[index].posterPath
                                              .toString(),
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Image.asset(
                                          'assets/images/loading_dark.gif',
                                          fit: BoxFit.cover,
                                        );
                                      },
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        if (stackTrace != null) {
                                          return const Center(
                                              child: Icon(Icons.error));
                                        }
                                        return const Center(
                                            child: Icon(Icons.error));
                                      },
                                    )),
                          const Positioned.fill(
                              child: Icon(
                            Icons.play_arrow,
                            size: 50,
                          ))
                        ]),
                      );
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSynopsis(BuildContext context, InformationState state) {
    int maxLength = 450;
    String overview = '';
    if (state.detail != null) {
      if (state.detail!.overview.length > maxLength) {
        if (state.isReadMore) {
          overview = state.detail!.overview.substring(0, maxLength) + '...';
        } else {
          overview = state.detail!.overview;
        }
      } else {
        overview = state.detail!.overview;
      }
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: const Text(
                'Synopsis',
                style: StringConstraints.h2Bold,
              )),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      overview,
                      style: StringConstraints.h3,
                    ),
                    state.detail != null
                        ? state.detail!.overview.length > maxLength
                            ? GestureDetector(
                                onTap: () {
                                  BlocProvider.of<InformationBloc>(context).add(
                                      ReadMoreOfSynopsisInforEvent(
                                          isReadMore: !state.isReadMore));
                                },
                                child: Text(
                                    state.isReadMore
                                        ? 'Show more'
                                        : 'Show less',
                                    style: StringConstraints.h6BlueBold),
                              )
                            : const Text('',
                                style: StringConstraints.h6BlueBold)
                        : const Text('', style: StringConstraints.h6BlueBold)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildReviewFilm(BuildContext context, InformationState state) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.25,
      child: ListView.builder(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: state.reviews.length,
          itemBuilder: (context, index) {
            return _buildItemReview(context, state.reviews[index]);
          }),
    );
  }

  Widget _buildItemReview(BuildContext context, ReviewImp reviewImp) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
              radius: 20,
              child: ClipOval(
                child: reviewImp.authorDetails.avatarPath.isNotEmpty
                    ? Image.network(
                        reviewImp.authorDetails.avatarPath.substring(
                            1, reviewImp.authorDetails.avatarPath.length),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Image.asset(
                            'assets/images/loading_dark.gif',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          );
                        },
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          if (stackTrace != null) {
                            return const Center(child: Icon(Icons.error));
                          }
                          return const Center(child: Icon(Icons.error));
                        },
                      )
                    : Image.asset(
                        'assets/images/no_avatar.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
              )),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(reviewImp.author),
                  Visibility(
                    visible: reviewImp.authorDetails.rating != null,
                    child: Row(
                      children: [
                        RatingBar.builder(
                            initialRating:
                                reviewImp.authorDetails.rating != null
                                    ? reviewImp.authorDetails.rating! / 2.0
                                    : 5,
                            minRating: 1,
                            itemCount: 5,
                            itemSize: 15,
                            tapOnlyMode: true,
                            allowHalfRating: true,
                            itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                            onRatingUpdate: (rating) {
                            }),
                        Text(
                          '(${reviewImp.authorDetails.rating != null ? reviewImp.authorDetails.rating! / 2.0 : 5})',
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Text(
                      reviewImp.content.toString(),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Text(
                        'Created at: ${DateFormat('dd-MM-yyyy').format(reviewImp.createdAt)}'),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLoadImage({required String url}) {
    return Image.network(
      url,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Image.asset(
          'assets/images/loading_dark.gif',
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        );
      },
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (context, error, stackTrace) {
        if (stackTrace != null) return const Center(child: Icon(Icons.error));
        return const Center(child: Icon(Icons.error));
      },
    );
  }

  Widget _buildImageDefault({required String url}) {
    return Image.asset(
      url,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }

  Widget _buildAddToCart(BuildContext context, InformationState state) {
    return Container(
      margin: const EdgeInsets.only(left: 30),
      decoration: BoxDecoration(
          color: state.isInCart ? Colors.red : Colors.blue,
          borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        width: double.infinity,
        child: TextButton(
          onPressed: () {
            BlocProvider.of<InformationBloc>(context)
                .add(AddCartInforEvent(filmData: filmData));
          },
          child: const Text(
            'Add to cart',
            style: StringConstraints.h2Bold,
          ),
        ),
      ),
    );
  }

  Widget _builDialog(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: MediaQuery.of(context).size.height * 0.2,
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(15.0),
              child: const Center(
                child: Text(
                  'The skill are improving',
                  style: StringConstraints.h2BoldDark,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned(
                top: 10,
                right: 0,
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.cancel,
                      color: Colors.red,
                      size: 30,
                    )))
          ],
        ),
      ),
    );
  }
}
