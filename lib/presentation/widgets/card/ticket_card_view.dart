import 'package:flutter/material.dart';
import 'package:movie_ticket/common/app_colors.dart';
import 'package:movie_ticket/common/app_text_style.dart';
import 'package:movie_ticket/common/date_contants.dart';
import 'package:movie_ticket/common/global.dart';
import 'package:movie_ticket/data/models/film_data.dart';
import 'package:movie_ticket/presentation/widgets/contants/contants.dart';

class TicketCardView extends StatelessWidget {
  const TicketCardView({
    required this.filmData,
    required this.time,
    required this.date,
    required this.cinemaName,
    required this.listSeat,
    Key? key,
  }) : super(key: key);
  final FilmData filmData;
  final String time;
  final DateTime date;
  final String cinemaName;
  final List<String> listSeat;

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
        child: Stack(
          children: [
            Row(
              children: [
                _buildImage(context),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildInfoRight(context),
                ),
                const SizedBox(width: 24),
              ],
            ),
            if (DateTime.now().compareTo(_buildTime(date: date, time: time)) ==
                1)
              _buildExpire(context),
          ],
        ),
      ),
    );
  }
}

extension TicketCardViewBasicComponents on TicketCardView {
  Widget _buildImage(BuildContext context) {
    return AspectRatio(
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
    );
  }

  Widget _buildInfoRight(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        Text(
          filmData.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyle.medium16.copyWith(color: AppColors.mainText),
        ),
        const SizedBox(height: 10),
        Text(
          time + ', ' + date.dateToDateTicket(),
          overflow: TextOverflow.ellipsis,
          style: AppTextStyle.regular14
              .copyWith(color: AppColors.mainText.withOpacity(0.7)),
        ),
        const SizedBox(height: 5),
        Text(
          'Seat: ' + listSeat.seatToString(),
          overflow: TextOverflow.ellipsis,
          style: AppTextStyle.regular14
              .copyWith(color: AppColors.mainText.withOpacity(0.7)),
        ),
        const SizedBox(height: 5),
        Text(
          cinemaName,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyle.regular14
              .copyWith(color: AppColors.mainText.withOpacity(0.7)),
        ),
      ],
    );
  }

  Widget _buildExpire(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.5), borderRadius: BorderRadius.circular(8)),
            child: Text(
              'Expire',
              style: AppTextStyle.medium12.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }

  DateTime _buildTime({required DateTime date, required String time}) {
    return DateTime(date.year, date.month, date.day,
        time.stringToTimeChoose.hour, time.stringToTimeChoose.minute);
  }
}
