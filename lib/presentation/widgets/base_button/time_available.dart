import 'package:flutter/material.dart';
import 'package:movie_ticket/common/app_colors.dart';
import 'package:movie_ticket/common/app_text_style.dart';
import 'package:movie_ticket/presentation/widgets/contants/contants.dart';

class TimeAvailable extends StatelessWidget {
  const TimeAvailable({
    required this.time,
    required this.onPressed,
    required this.isSelected,
    Key? key,
  }) : super(key: key);
  final CinemaTime time;
  final Function(CinemaTime) onPressed;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88.0,
      height: 44.0,
      margin: const EdgeInsets.only(left: 24),
      decoration: BoxDecoration(
          color: isSelected ? AppColors.mainColor : AppColors.dartBackground2,
          borderRadius: BorderRadius.circular(14.0)),
      child: TextButton(
        onPressed: () {
          onPressed(time);
        },
        child: Text(
          time.title,
          style: AppTextStyle.regular16.copyWith(color: AppColors.mainText),
        ),
      ),
    );
  }
}
