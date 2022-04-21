import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:movie_ticket/blocs/information/information_bloc.dart';
import 'package:movie_ticket/blocs/information/information_event.dart';
import 'package:movie_ticket/blocs/information/information_state.dart';
import 'package:movie_ticket/common/app_colors.dart';
import 'package:movie_ticket/common/app_text_styles.dart';
import 'package:movie_ticket/common/global.dart';
import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/data/models/film_data.dart';
import 'package:movie_ticket/data/models/review.dart';
import 'package:movie_ticket/presentation/order_ticket/cinema_and_date_screen.dart';
import 'package:movie_ticket/presentation/order_ticket/trailer_screen.dart';
import 'package:movie_ticket/presentation/widgets/snack_bar/custom_snack_bar.dart';

class InformationScreen extends StatelessWidget {
  final FilmData filmData;
  const InformationScreen({Key? key, required this.filmData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InformationBloc>(
      create: (context) =>
          InformationBloc()..add(StartedInforEvent(id: filmData.id)),
      child: BlocConsumer<InformationBloc, InformationState>(
        listener: (context, state) {
          if (state.viewState == ViewState.isFailure) {
            if (state.message != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(
                  message: state.message.toString(),
                  isSuccess: false,
                  milliseconds: 1000,
                ),
              );
            }
          }
          if (state.viewState == ViewState.isSuccess) {
            if (state.message != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                CustomSnackBar(
                  message: state.message.toString(),
                  isSuccess: true,
                  milliseconds: 1000,
                ),
              );
            }
          }
          if (state.trailerVideo != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TrailerScreen(
                  url: state.trailerVideo!,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.dartBackground1,
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
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.dartBackground2,
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            child: state.detail != null
                ? _buildLoadImage(
                    url: Global.imageURL + state.detail!.backdropPath)
                : _buildImageDefault(url: 'assets/images/loading_dark.gif'),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios, size: 30),
            ),
          ),
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          state.detail != null
                              ? state.detail!.originalTitle
                              : '',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: AppTextStyles.h2Bold,
                        ),
                      ),
                      if (state.detail != null)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RatingBar.builder(
                                initialRating: state.detail != null
                                    ? state.detail!.voteAverage / 2.0
                                    : 0,
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
                          style: AppTextStyles.h7,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        state.detail != null
                            ? DateFormat('dd-MM-yyyy')
                                .format(state.detail!.releaseDate)
                            : '',
                        style: AppTextStyles.h7,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TrailerScreen(
                          url: state.infoVideo!,
                        ),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.play_arrow,
                    size: 50,
                  ),
                )
              ],
            ),
          )
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
                        ? AppTextStyles.h8
                        : AppTextStyles.h8Bold,
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
                            ? AppTextStyles.h8
                            : AppTextStyles.h8Bold)),
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
              style: AppTextStyles.h2Bold, textAlign: TextAlign.start),
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
                    width: 80,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.dartBackground2,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: state.casts[index].profilePath != null
                                  ? Image.network(
                                      Global.imageURL +
                                          state.casts[index].profilePath
                                              .toString(),
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Center(
                                            child: Icon(Icons.error));
                                      },
                                    )
                                  : Image.asset('assets/images/no_avatar.png'),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Text(
                            state.casts[index].originalName,
                            style: AppTextStyles.h7,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
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
                style: AppTextStyles.h2Bold, textAlign: TextAlign.start),
          ),
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.20,
            child: Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.similarMovies.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        BlocProvider.of<InformationBloc>(context).add(
                          GetTrailerVideoInforEvent(
                              id: state.similarMovies[index].id),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(
                          width: 299,
                          height: 225,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.dartBackground2,
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  Global.imageURL +
                                      state.similarMovies[index].backdropPath!
                                          .toString(),
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Center(
                                        child: Icon(Icons.error));
                                  },
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.play_arrow,
                                      size: 50,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
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
                style: AppTextStyles.h2Bold,
              )),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                child: GestureDetector(
                  onTap: () {
                    BlocProvider.of<InformationBloc>(context).add(
                        ReadMoreOfSynopsisInforEvent(
                            isReadMore: !state.isReadMore));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        overview,
                        style: AppTextStyles.h3,
                      ),
                      state.detail != null
                          ? state.detail!.overview.length > maxLength
                              ? Text(
                                  state.isReadMore ? 'Show more' : 'Show less',
                                  style: AppTextStyles.h6BlueBold)
                              : const Text('', style: AppTextStyles.h6BlueBold)
                          : const Text('', style: AppTextStyles.h6BlueBold)
                    ],
                  ),
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
                            onRatingUpdate: (rating) {}),
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

  Widget _buildLoadImage({String? url}) {
    return Image.network(
      url!,
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
        return const Center(
          child: Icon(Icons.error),
        );
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
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CinemaAndDateView(
                  filmData: filmData,
                ),
              ),
            );
            // BlocProvider.of<InformationBloc>(context)
            //     .add(AddCartInforEvent(filmData: filmData));
          },
          child: const Text(
            'Add to cart',
            style: AppTextStyles.h2Bold,
          ),
        ),
      ),
    );
  }
}
