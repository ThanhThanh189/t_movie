import 'package:flutter/material.dart';
import 'package:movie_ticket/common/app_colors.dart';
import 'package:movie_ticket/common/app_images.dart';
import 'package:movie_ticket/common/app_text_style.dart';
import 'package:movie_ticket/presentation/widgets/contants/contants.dart';

class Seat extends StatelessWidget {
  const Seat({
    required this.onPressed,
    required this.listSeatBooked,
    required this.listSeatSelected,
    Key? key,
  }) : super(key: key);

  final List<String> listSeatSelected;
  final List<String> listSeatBooked;
  final Function(String) onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildSeat(context),
        Expanded(
          child: _buildScreen(context),
        )
      ],
    );
  }
}

extension SeatBasicComponents on Seat {
  Widget _buildSeat(BuildContext context) {
    return SizedBox(
      height: 420,
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            margin: const EdgeInsets.only(left: 10),
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Row(
                    children: [
                      _buildGridView(context,
                          crossAxisCount: 4,
                          seats: SeatA6.values.map((e) => e.title).toList()),
                      _buildGridView(context,
                          crossAxisCount: 4,
                          seats: SeatA12.values.map((e) => e.title).toList()),
                      _buildGridView(context,
                          crossAxisCount: 4,
                          seats: SeatA18.values.map((e) => e.title).toList()),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                  flex: 6,
                  child: Row(
                    children: [
                      _buildGridView(context,
                          crossAxisCount: 6,
                          seats: SeatE4.values.map((e) => e.title).toList()),
                      _buildGridView(context,
                          crossAxisCount: 6,
                          seats: SeatE10.values.map((e) => e.title).toList()),
                      _buildGridView(context,
                          crossAxisCount: 6,
                          seats: SeatE14.values.map((e) => e.title).toList()),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget _buildGridView(BuildContext context,
      {required int crossAxisCount, required List<String> seats}) {
    return Container(
      margin: const EdgeInsets.only(right: 50.0),
      height: double.infinity,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 20.0),
        itemCount: seats.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: listSeatBooked.contains(seats[index])
                ? null
                : () {
                    onPressed(seats[index]);
                  },
            child: Container(
              width: 26.0,
              height: 26.0,
              decoration: BoxDecoration(
                  color: listSeatBooked.contains(seats[index])
                      ? AppColors.greyBackground1
                      : listSeatSelected.contains(seats[index])
                          ? AppColors.mainColor
                          : AppColors.dartBackground2,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  seats[index],
                  style: AppTextStyle.medium14,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildScreen(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Screen',
          style: AppTextStyle.light12,
        ),
        Image.asset(
          AppImages.seatScreen,
          width: double.infinity,
        ),
      ],
    );
  }
}
