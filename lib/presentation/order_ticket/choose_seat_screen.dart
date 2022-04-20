import 'package:flutter/material.dart';
import 'package:movie_ticket/common/app_colors.dart';
import 'package:movie_ticket/common/app_text_style.dart';
import 'package:movie_ticket/common/global.dart';
import 'package:movie_ticket/data/models/film_data.dart';
import 'package:movie_ticket/presentation/cart/check_out_screen.dart';
import 'package:movie_ticket/presentation/widgets/base_appbar/base_appbar_view.dart';
import 'package:movie_ticket/presentation/widgets/base_button/base_button.dart';
import 'package:movie_ticket/presentation/widgets/contants/contants.dart';
import 'package:movie_ticket/presentation/widgets/seat/seat.dart';

class ChooseSeatScreen extends StatelessWidget {
  const ChooseSeatScreen({
    required this.filmData,
    required this.chooseTime,
    required this.chooseDate,
    Key? key,
  }) : super(key: key);
  final FilmData filmData;
  final CinemaTime chooseTime;
  final DateTime chooseDate;

  @override
  Widget build(BuildContext context) {
    // print(
    //     'value: ${filmData.id},${chooseTime.title},${chooseDate.dateToString()}');
    return Scaffold(
        backgroundColor: AppColors.dartBackground1,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 10),
              Expanded(child: _buildSeat(context)),
              _buildBookTicket(context),
            ],
          ),
        ));
  }
}

extension ChooseSeatScreenBasicComponent on ChooseSeatScreen {
  Widget _buildHeader(BuildContext context) {
    return Container(
      color: AppColors.veryDartBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          _buildAppBar(context),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: _buildCinemaName(context),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: _buildStatusSeat(context),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return BaseAppBarView(
      title: 'Ralph Breaks the Internet',
      onBackTap: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget _buildCinemaName(BuildContext context) {
    return Text(
      'FX Sudirman XXI',
      style: AppTextStyle.light12.copyWith(color: AppColors.mainText),
    );
  }

  Widget _buildStatusSeat(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: AppColors.dartBackground2,
          ),
        ),
        Text(
          'Available',
          style: AppTextStyle.regular14.copyWith(
            color: AppColors.mainText,
          ),
        ),
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: AppColors.greyBackground1,
          ),
        ),
        Text(
          'Booked',
          style: AppTextStyle.regular14.copyWith(
            color: AppColors.mainText,
          ),
        ),
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: AppColors.mainColor,
          ),
        ),
        Text(
          'Your Seat',
          style: AppTextStyle.regular14.copyWith(
            color: AppColors.mainText,
          ),
        ),
      ],
    );
  }

  Widget _buildSeat(BuildContext context) {
    return const Seat();
  }

  Widget _buildBookTicket(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 22, bottom: 22),
      width: double.infinity,
      color: AppColors.veryDartBackground,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Price ( 3 Ticket)',
                style:
                    AppTextStyle.regular14.copyWith(color: AppColors.mainText),
              ),
              Text(
                'Rp 150.000',
                style:
                    AppTextStyle.semiBold20.copyWith(color: AppColors.mainText),
              ),
            ],
          ),
          BaseButton(
            text: 'Book Ticket',
            isVisible: true,
            isExpanded: false,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CheckOutScreen(
                        listFilmData: [
                          FilmData(
                              adult: false,
                              id: 1,
                              backdropPath: Global.imageURL +
                                  "/iQFcwSGbZXMkeyKrxbPnwnRo5fl.jpg",
                              originalLanguage: 'originalLanguage',
                              originalTitle: 'originalTitle',
                              overview: 'overview',
                              popularity: 2022,
                              posterPath: 'posterPath',
                              releaseDate: DateTime(2022, 03, 19),
                              title: 'title',
                              video: false,
                              voteAverage: 8,
                              voteCount: 10)
                        ],
                      )));
            },
          )
        ],
      ),
    );
  }
}
