import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_ticket/blocs/cinema_and_date/cinema_and_date_bloc.dart';
import 'package:movie_ticket/blocs/cinema_and_date/cinema_and_date_event.dart';
import 'package:movie_ticket/blocs/cinema_and_date/cinema_and_date_state.dart';
import 'package:movie_ticket/common/app_colors.dart';
import 'package:movie_ticket/common/app_text_style.dart';
import 'package:movie_ticket/data/models/film_data.dart';
import 'package:movie_ticket/presentation/order_ticket/choose_seat_screen.dart';
import 'package:movie_ticket/presentation/widgets/base_appbar/base_appbar_view.dart';
import 'package:movie_ticket/presentation/widgets/base_button/dated_available.dart';
import 'package:movie_ticket/presentation/widgets/base_button/next_button.dart';
import 'package:movie_ticket/presentation/widgets/base_button/time_available.dart';
import 'package:movie_ticket/presentation/widgets/contants/contants.dart';

class CinemaAndDateView extends StatelessWidget {
  const CinemaAndDateView({
    required this.filmData,
    Key? key,
  }) : super(key: key);
  final FilmData filmData;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CinemaAndDateBloc>(
      create: (context) => CinemaAndDateBloc()
        ..add(
          StartedCinemaAndDateEvent(),
        ),
      child: BlocConsumer<CinemaAndDateBloc, CinemaAndDateState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.dartBackground1,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 26),
                    BaseAppBarView(
                      title: 'Ralph Breaks the Internet',
                      onBackTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(height: 24),
                    _buildListNumberDay(context, state: state),
                    const SizedBox(height: 40),
                    _buildTimeListView(
                      context,
                      title: CinemaName.centralParkCGV.title,
                      state: state,
                    ),
                    const SizedBox(height: 24),
                    _buildTimeListView(
                      context,
                      title: CinemaName.fxSudirmanXXI.title,
                      state: state,
                    ),
                    const SizedBox(height: 24),
                    _buildTimeListView(
                      context,
                      title: CinemaName.keapaGadingIMAX.title,
                      state: state,
                    ),
                    const SizedBox(height: 24),
                    _buildTimeListView(
                      context,
                      title: CinemaName.vincomPlazaCGV.title,
                      state: state,
                    ),
                    const SizedBox(height: 24),
                    _buildButtonNext(context, state: state),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

extension CinemaAndDateBasicComponents on CinemaAndDateView {
  Widget _buildListNumberDay(
    BuildContext context, {
    required CinemaAndDateState state,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Text(
            'Choose Date',
            style: AppTextStyle.medium20.copyWith(color: AppColors.mainText),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 88,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: state.listDateTime.length,
            itemBuilder: (context, index) => DatedAvaible(
              isSelected: state.day == state.listDateTime[index],
              dateTitle: state.listDateTime[index],
              onPressed: (value) {
                BlocProvider.of<CinemaAndDateBloc>(context).add(
                  SetDayCinemaAndDateEvent(chooseDay: value),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeListView(
    BuildContext context, {
    required String title,
    required CinemaAndDateState state,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Text(
            title,
            style: AppTextStyle.medium20.copyWith(color: AppColors.mainText),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 44,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: CinemaTime.values.length,
            itemBuilder: (context, index) => TimeAvailable(
              isSelected: title == state.cinemaName.title &&
                  CinemaTime.values[index] == state.time,
              time: CinemaTime.values[index],
              onPressed: (value) {
                BlocProvider.of<CinemaAndDateBloc>(context).add(
                  SetTimeCinemaAndDateEvent(
                    time: value,
                    cinemaName: CinemaName.values[CinemaName.values
                        .indexWhere((element) => element.title == title)],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButtonNext(
    BuildContext context, {
    required CinemaAndDateState state,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        NextButton(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ChooseSeatScreen(
                    filmData: filmData,
                    chooseTime: state.time ?? CinemaTime.t1,
                    chooseDate: state.day ?? DateTime.now(),
                    cinemaName: state.cinemaName,
                  ),
                ),
              );
            },
            isSlected: state.day != null && state.time != null),
      ],
    );
  }
}
