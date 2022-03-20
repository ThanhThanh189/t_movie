import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:movie_ticket/blocs/search/search_bloc.dart';
import 'package:movie_ticket/blocs/search/search_event.dart';
import 'package:movie_ticket/blocs/search/search_state.dart';
import 'package:movie_ticket/common/color_constraints.dart';
import 'package:movie_ticket/common/global.dart';
import 'package:movie_ticket/data/repositories/film_repository.dart';
import 'package:movie_ticket/ui/order_ticket/information_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({
    Key? key,
    required this.filmRepository,
  }) : super(key: key);

  final FilmRepository filmRepository;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchBloc>(
      create: (context) => SearchBloc(filmRepository: filmRepository),
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(85.0),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus();
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          child: const Icon(
                            Icons.arrow_back,
                            size: 30,
                          ),
                        )),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: ColorConstraints.dartBackground2,
                        ),
                        child: TextField(
                          autofocus: true,
                          controller: _searchController,
                          onChanged: (value) {
                            // _searchController.text = value;
                            BlocProvider.of<SearchBloc>(context)
                                .add(SearchByNameSearchEvent(nameFilm: value));
                          },
                          decoration: InputDecoration(
                            hintText: 'Search Movie',
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: _searchController.text != ''
                                ? IconButton(
                                    onPressed: () {
                                      _searchController.clear();
                                      FocusScope.of(context).unfocus();
                                      BlocProvider.of<SearchBloc>(context)
                                          .add(ClearSearchEvent());
                                    },
                                    icon: const Icon(Icons.cancel))
                                : null,
                            border:
                                const OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              body: state.listFilmData.isNotEmpty
                  ? _buildListSearch(context, state)
                  : Center(child: Text('${state.message}')),
            ),
          );
        },
      ),
    );
  }

  Widget _buildListSearch(BuildContext context, SearchState state) {
    return ListView.builder(
        itemCount: state.listFilmData.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => InformationScreen(
                      filmRepository: filmRepository,
                      filmData: state.listFilmData[index])));
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
              width: double.infinity,
              height: 100,
              // MediaQuery.of(context).size.height * 0.1,
              child: Row(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child:
                            state.listFilmData[index].backdropPath != null
                                ? _buildLoadImage(
                                    url: Global.imageURL +
                                        state.listFilmData[index]
                                            .backdropPath!)
                                : Image.asset(
                                    'assets/images/loading_dark.gif',
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
                            state.listFilmData[index].originalTitle,
                            maxLines: 2,
                          ),
                          Row(
                            children: [
                              RatingBar.builder(
                                  initialRating: state.listFilmData[index]
                                          .voteAverage /
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
                                  onRatingUpdate: (rating) {
                                  }),
                              Text(
                                '(${state.listFilmData[index].voteAverage / 2})',
                              )
                            ],
                          ),
                          Text(
                              DateFormat('dd-MM-yyyy').format(state.listFilmData[index].releaseDate)),
                        ]),
                  ),
                  const Icon(Icons.arrow_circle_up_outlined, size: 30),
                ],
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
}
