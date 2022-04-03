import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/view_all/view_all_bloc.dart';
import 'package:movie_ticket/blocs/view_all/view_all_event.dart';
import 'package:movie_ticket/blocs/view_all/view_all_state.dart';
import 'package:movie_ticket/common/app_colors.dart';
import 'package:movie_ticket/common/global.dart';
import 'package:movie_ticket/common/view_state.dart';
import 'package:movie_ticket/ui/order_ticket/information_screen.dart';

class ViewAllScreen extends StatelessWidget {
  final String namePage;
  const ViewAllScreen({Key? key, required this.namePage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dartBackground1,
      appBar: AppBar(
        title: const Text('View All'),
      ),
      body: BlocProvider<ViewAllBloc>(
        create: (context) =>
            ViewAllBloc()..add(StartedViewAllEvent(namePage: namePage)),
        child: BlocBuilder<ViewAllBloc, ViewAllState>(
          builder: (context, state) {
            return state.viewState == ViewState.isLoading
                ? const SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent:
                                          MediaQuery.of(context).size.width *
                                              0.5,
                                      childAspectRatio: 1,
                                      crossAxisSpacing: 10.0),
                              itemCount: state.listFilmData.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                      return InformationScreen(
                                          filmData: state.listFilmData[index]);
                                    }));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: state.listFilmData[index]
                                                      .backdropPath !=
                                                  null
                                              ? Image.network(
                                                  Global.imageURL +
                                                      state.listFilmData[index]
                                                          .backdropPath!,
                                                  loadingBuilder: (context,
                                                      child, loadingProgress) {
                                                    if (loadingProgress ==
                                                        null) {
                                                      return child;
                                                    }
                                                    return Image.asset(
                                                      'assets/images/loading_dark.gif',
                                                      fit: BoxFit.cover,
                                                      width: double.infinity,
                                                      height: double.infinity,
                                                    );
                                                  },
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    if (stackTrace != null) {
                                                      return const Center(
                                                          child: Icon(
                                                              Icons.error));
                                                    }
                                                    return const Center(
                                                        child:
                                                            Icon(Icons.error));
                                                  },
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                )
                                              : Image.asset(
                                                  'assets/images/loading_dark.gif',
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                          state.isSelectLoadMore
                              ? Visibility(
                                  child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.all(20),
                                        child:
                                            const CircularProgressIndicator())
                                  ],
                                ))
                              : Visibility(
                                  visible: !state.isLastPage,
                                  child: Container(
                                    margin: const EdgeInsets.all(20),
                                    child: Center(
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        child: TextButton(
                                          onPressed: () {
                                            BlocProvider.of<ViewAllBloc>(
                                                    context)
                                                .add(LoadMoreViewAllEvent(
                                                    namePage: namePage,
                                                    numberPage:
                                                        state.pageCurrent + 1));
                                          },
                                          child: const Text('Xem thêm ...'),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                        ],
                      ),
                    ));
          },
        ),
      ),
    );
  }
}
