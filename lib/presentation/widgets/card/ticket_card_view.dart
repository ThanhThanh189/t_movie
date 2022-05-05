import 'package:flutter/material.dart';
import 'package:movie_ticket/common/app_colors.dart';
import 'package:movie_ticket/common/app_text_style.dart';
import 'package:movie_ticket/common/global.dart';
import 'package:movie_ticket/data/models/film_data.dart';

class TicketCardView extends StatelessWidget {
  const TicketCardView({
    required this.filmData,
    required this.time,
    required this.date,
    required this.cinemaName,
    Key? key,
  }) : super(key: key);
  final FilmData filmData;
  final String time;
  final String date;
  final String cinemaName;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 343 / 120,
      child: Container(
        margin: const EdgeInsets.only(right: 10, left: 10, top: 5, bottom: 5),
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
            AspectRatio(
              aspectRatio: 84 / 120,
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
                          Global.imageURL + filmData.posterPath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(child: Icon(Icons.error));
                          },
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Text(
                    filmData.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.medium16
                        .copyWith(color: AppColors.mainText),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    time + ', ' + date,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.regular14
                        .copyWith(color: AppColors.mainText.withOpacity(0.7)),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    cinemaName,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.regular14
                        .copyWith(color: AppColors.mainText.withOpacity(0.7)),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 24),
          ],
        ),
      ),
    );
  }
}
