import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_ticket/blocs/home/home_bloc.dart';
import 'package:movie_ticket/blocs/home/home_event.dart';
import 'package:movie_ticket/blocs/home/home_state.dart';
import 'package:movie_ticket/common/app_colors.dart';
import 'package:movie_ticket/common/app_text_style.dart';
import 'package:movie_ticket/common/app_text_styles.dart';
import 'package:movie_ticket/common/global.dart';
import 'package:movie_ticket/data/models/film_data.dart';
import 'package:movie_ticket/presentation/order_ticket/information_screen.dart';
import 'package:movie_ticket/presentation/order_ticket/search_screen.dart';
import 'package:movie_ticket/presentation/order_ticket/view_all_screen.dart';
import 'package:movie_ticket/presentation/widgets/images/profile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc()..add(StartedHomeEvent()),
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, homeState) {},
        builder: (context, homeState) {
          return Scaffold(
            backgroundColor: AppColors.dartBackground1,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    //Find your best movie
                    _buildAvatar(context, state: homeState),
                    // search movie
                    _buildSearchMovie(context),
                    //Now playing
                    _buildListNowPlaying(context, true, homeState),
                    _buildListNowPlaying(context, false, homeState),
                    //Coming soon
                    _buildListComingSoon(context, homeState),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAvatar(BuildContext context, {required HomeState state}) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: Container(
              margin: const EdgeInsets.only(right: 100),
              child: const Text(
                'Find Your Best Movie',
                style: AppTextStyle.medium24,
                textAlign: TextAlign.start,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Profile(
              image: state.user?.photoURL,
              sizeAvatar: 48,
              isEdit: false,
              onTap: () {},
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSearchMovie(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(120),
          color: AppColors.dartBackground2),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SearchScreen()));
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            children: const [
              Icon(Icons.search),
              SizedBox(
                width: 10,
              ),
              Text(
                'Search Movie',
                style: AppTextStyles.h2,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListNowPlaying(
      BuildContext context, bool isTopRated, HomeState homeState) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // now playing and view all
        Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isTopRated ? 'Top Rating' : 'Now Playing',
                style: AppTextStyles.h5,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ViewAllScreen(
                            namePage: isTopRated
                                ? Global.listTopRated
                                : Global.listNowPlaying,
                          )));
                },
                child: const Text(
                  'View all',
                  style: AppTextStyles.h6Blue,
                ),
              )
            ],
          ),
        ),
        // List now playing
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: homeState.listTopRated.length,
            itemBuilder: (context, index) {
              return _buildItemNowPlaying(
                  context,
                  isTopRated
                      ? homeState.listTopRated[index]
                      : homeState.listNowPlaying[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildItemNowPlaying(BuildContext context, FilmData filmData) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return InformationScreen(
                filmData: filmData,
              );
            },
          ),
        );
      },
      child: Container(
        width: 299,
        height: 225,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.dartBackground2,
        ),
        margin: const EdgeInsets.all(5),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                Global.imageURL + filmData.backdropPath!,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Icon(Icons.error));
                },
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    filmData.originalTitle,
                    style: AppTextStyles.h2Bold,
                  ),
                  Row(
                    children: [
                      RatingBar.builder(
                          initialRating: filmData.voteAverage.toDouble() / 2.0,
                          minRating: 1,
                          itemCount: 5,
                          itemSize: 20,
                          tapOnlyMode: true,
                          allowHalfRating: true,
                          itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                          onRatingUpdate: (rating) {}),
                      Text(
                        '(${filmData.voteAverage / 2.0})',
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListComingSoon(BuildContext context, HomeState homeState) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // now playing and view all
        Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Coming Soon',
                style: AppTextStyles.h5,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ViewAllScreen(
                            namePage: Global.listComingSoon,
                          )));
                },
                child: const Text(
                  'View all',
                  style: AppTextStyles.h6Blue,
                ),
              )
            ],
          ),
        ),
        // List now playing
        SizedBox(
          height: 200,
          width: double.infinity,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: homeState.listComingSoon.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 100,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemBuilder: (context, index) {
              return _buildItemComingSoon(
                  context, homeState.listComingSoon[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildItemComingSoon(BuildContext context, FilmData filmData) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return InformationScreen(
                filmData: filmData,
              );
            },
          ),
        );
      },
      child: Container(
        height: 100,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.dartBackground2,
        ),
        margin: const EdgeInsets.all(5),
        child: Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              Global.imageURL + filmData.backdropPath!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                return const Center(child: Icon(Icons.error));
              },
            ),
          ),
        ]),
      ),
    );
  }
}
