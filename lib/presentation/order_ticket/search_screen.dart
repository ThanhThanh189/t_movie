import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/search/search_bloc.dart';
import 'package:movie_ticket/blocs/search/search_event.dart';
import 'package:movie_ticket/blocs/search/search_state.dart';
import 'package:movie_ticket/common/app_colors.dart';
import 'package:movie_ticket/presentation/order_ticket/information_screen.dart';
import 'package:movie_ticket/presentation/widgets/card/card_view.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({
    Key? key,
  }) : super(key: key);

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchBloc>(
      create: (context) => SearchBloc(),
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.dartBackground1,
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
                          color: AppColors.dartBackground2,
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
                            border: const OutlineInputBorder(
                                borderSide: BorderSide.none),
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
                        filmData: state.listFilmData[index])));
              },
              child: CardView(filmData: state.listFilmData[index]));
        });
  }
}
