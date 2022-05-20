import 'package:flutter/material.dart';
import 'package:movie_ticket/common/app_colors.dart';
import 'package:movie_ticket/common/app_text_style.dart';
import 'package:movie_ticket/common/date_contants.dart';

class DatedAvaible extends StatelessWidget {
  const DatedAvaible({
    required this.dateTitle,
    required this.onPressed,
    required this.isSelected,
    Key? key,
  }) : super(key: key);

  final Function(DateTime) onPressed;
  final DateTime dateTitle;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.0,
      height: 88.0,
      margin: const EdgeInsets.only(left: 24),
      decoration: BoxDecoration(
          color: isSelected ? AppColors.mainColor : AppColors.dartBackground2,
          borderRadius: BorderRadius.circular(14.0)),
      child: TextButton(
        onPressed: () {
          onPressed(dateTitle);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              dateTitle.dateToWeekday(),
              style: AppTextStyle.regular16.copyWith(color: AppColors.mainText),
            ),
            Text(
              dateTitle.dateToDayAndMonth(),
              style: AppTextStyle.regular16.copyWith(color: AppColors.mainText),
            )
          ],
        ),
      ),
    );
  }
}
