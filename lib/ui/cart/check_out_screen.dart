import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:movie_ticket/common/global.dart';
import 'package:movie_ticket/common/string_constraints.dart';
import 'package:movie_ticket/data/models/film_data.dart';
import 'package:movie_ticket/data/repositories/film_repository.dart';
import 'package:movie_ticket/ui/order_ticket/information_screen.dart';

class CheckOutScreen extends StatelessWidget {
  final List<FilmData> listFilmData;
  final FilmRepository filmRepository;
  const CheckOutScreen({Key? key, required this.listFilmData, required this.filmRepository}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop({'payment': false});
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Checkout'),
          ),
          body: ListView.builder(
              itemCount: listFilmData.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      _buildInforFilm(context, listFilmData[index]),
                      _buildInforPrice(context, listFilmData[index]),
                      Visibility(
                          visible: index == listFilmData.length - 1,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 65),
                          ))
                    ],
                  ),
                );
              }),
          floatingActionButton: _buildAddToCart(context),
        ),
      ),
    );
  }

  Widget _buildInforFilm(BuildContext context, FilmData filmData) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => InformationScreen(
                filmRepository: filmRepository, filmData: filmData)));
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            height: 150,
            width: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: filmData.posterPath.isNotEmpty
                  ? _buildLoadImage(url: Global.imageURL + filmData.posterPath)
                  : Image.asset(
                      'assets/images/auto2.jpg',
                    ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  filmData.originalTitle,
                  maxLines: 2,
                  style: StringConstraints.h2Bold,
                ),
                Row(
                  children: [
                    RatingBar.builder(
                        initialRating: filmData.voteAverage / 2.0,
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
                      '(${filmData.voteAverage / 2.0})',
                    )
                  ],
                ),
                Text(
                  DateFormat('dd-MM-yyyy').format(filmData.releaseDate),
                  style: StringConstraints.h7,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInforPrice(BuildContext context, FilmData filmData) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20, bottom: 10),
          width: double.infinity,
          height: 1,
          color: Colors.grey,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'ID Order',
              style: StringConstraints.h8,
            ),
            Text('${filmData.id}', style: StringConstraints.h8)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Date & Time',
              style: StringConstraints.h8,
            ),
            Text(DateFormat('dd-MM-yyyy').format(filmData.releaseDate),
                style: StringConstraints.h8)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Price',
              style: StringConstraints.h8,
            ),
            Text('Rp 50.000 x 1', style: StringConstraints.h8)
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Total',
              style: StringConstraints.h8,
            ),
            Text('Rp 50.000', style: StringConstraints.h8Bold)
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 10),
          width: double.infinity,
          height: 1,
          color: Colors.grey,
        ),
      ],
    );
  }

  Widget _buildAddToCart(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 30),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: SizedBox(
          height: 50,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        'Total payment',
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'montserrat'),
                      ),
                      Text('đ${50000 * listFilmData.length}',
                          style: const TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'montserrat'))
                    ],
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                ),
                child: Center(
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop({'payment': true});
                      },
                      child: const Text(
                        'Payment',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'montserrat'),
                      )),
                ),
              )
            ],
          ),
        ));
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
