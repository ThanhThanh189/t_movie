import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:movie_ticket/blocs/favorite/favorite_bloc.dart';
import 'package:movie_ticket/blocs/favorite/favorite_event.dart';
import 'package:movie_ticket/blocs/favorite/favorite_state.dart';
import 'package:movie_ticket/common/global.dart';
import 'package:movie_ticket/common/string_constraints.dart';
import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/data/repositories/film_repository.dart';
import 'package:movie_ticket/ui/order_ticket/information_screen.dart';

class FavoriteScreen extends StatelessWidget {
  final FilmRepository filmRepository;
  const FavoriteScreen({
    Key? key,
    required this.filmRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite'),
        centerTitle: true,
      ),
      body: BlocProvider<FavoriteBloc>(
        create: (context) => FavoriteBloc()..add(StartedFavoriteEvent()),
        child: BlocConsumer<FavoriteBloc, FavoriteState>(
          listener: (context, state) {
            if (state.viewState == ViewState.isFailure) {
              state.message != '' && state.message != null
                  ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.message.toString()),
                      duration: const Duration(milliseconds: 1000)))
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
            return _buildListSearch(context, state);
          },
        ),
      ),
    );
  }

  Widget _buildListSearch(BuildContext context, FavoriteState state) {
    return ListView.builder(
        itemCount: state.listFilmData.length,
        itemBuilder: (context, index) {
          return Dismissible(
            background: Container(
              color: Colors.red,
            ),
            confirmDismiss: (directory) async {
              var result = await showDialog(
                  context: context,
                  builder: (_) => _builDialog(context, state, index));
              return result['confirm'];
            },
            key: Key(state.listFilmData[index].id.toString()),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => InformationScreen(
                        filmRepository: filmRepository,
                        filmData: state.listFilmData[index])));
              },
              child: Container(
                margin: EdgeInsets.only(
                    right: 10,
                    left: 10,
                    top: 10,
                    bottom: index == state.listFilmData.length - 1 ? 10 : 0),
                width: double.infinity,
                height: 100,
                child: Row(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: state.listFilmData[index].backdropPath != null
                              ? _buildLoadImage(
                                  url: Global.imageURL +
                                      state.listFilmData[index].backdropPath!)
                              : Image.asset(
                                  'assets/images/auto2.jpg',
                                ),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.listFilmData[index].title,
                              maxLines: 2,
                            ),
                            Row(
                              children: [
                                RatingBar.builder(
                                    initialRating:
                                        state.listFilmData[index].voteAverage /
                                            2,
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
                                  '(${state.listFilmData[index].voteAverage / 2})',
                                )
                              ],
                            ),
                            Text(DateFormat('dd-MM-yyyy').format(
                                state.listFilmData[index].releaseDate)),
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _buildLoadImage({required String url}) {
    return Image.network(
      url,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Image.asset(
          'assets/images/loading_dark.gif',
          fit: BoxFit.cover,
        );
      },
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        if (stackTrace != null) return const Center(child: Icon(Icons.error));
        return const Center(child: Icon(Icons.error));
      },
    );
  }

  Widget _builDialog(BuildContext context, FavoriteState state, int index) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: MediaQuery.of(context).size.height * 0.3,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(15.0),
                child: const Center(
                  child: Text(
                    'Are you sure you want to delete?',
                    style: StringConstraints.h2BoldDark,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(width: 1, color: Colors.black))),
                    child: TextButton(
                        onPressed: () {
                          BlocProvider.of<FavoriteBloc>(context).add(
                              DeleteFavoriteEvent(
                                  id: state.listFilmData[index].id));
                          Navigator.of(context).pop({'confirm': true});
                        },
                        child: const Text(
                          'OK',
                          style: StringConstraints.h2BoldRed,
                          textAlign: TextAlign.center,
                        )),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(width: 1, color: Colors.black))),
                    child: TextButton(
                        onPressed: () =>
                            Navigator.of(context).pop({'confirm': false}),
                        child: const Text(
                          'Cancel',
                          style: StringConstraints.h2BoldDark,
                          textAlign: TextAlign.center,
                        )),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
