import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:movie_ticket/common/app_colors.dart';
import 'package:movie_ticket/common/global.dart';
import 'package:movie_ticket/data/models/film_data.dart';

class CardView extends StatelessWidget {
  const CardView({
    required this.filmData,
    Key? key,
  }) : super(key: key);
  final FilmData filmData;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 343 / 100,
      child: Container(
        margin: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.dartBackground1,
            boxShadow: const [
              BoxShadow(
                  offset: Offset(0, 1),
                  blurRadius: 6,
                  color: AppColors.illustration2)
            ]),
        child: Row(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.dartBackground2,
                ),
                child: filmData.backdropPath == null
                    ? Container()
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          Global.imageURL + filmData.backdropPath!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(child: Icon(Icons.error));
                          },
                        ),
                      ),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 8, top: 5, right: 5, bottom: 8),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        filmData.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          RatingBar.builder(
                              initialRating: filmData.voteAverage / 2,
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
                            '(${filmData.voteAverage / 2})',
                          )
                        ],
                      ),
                      Text(DateFormat('dd-MM-yyyy')
                          .format(filmData.releaseDate)),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
