import 'package:flutter/material.dart';
import 'package:movie_ticket/common/app_colors.dart';
import 'package:movie_ticket/common/app_strings.dart';
import 'package:movie_ticket/common/app_text_style.dart';

class OptionTopUp extends StatelessWidget {
  const OptionTopUp({
    required this.number,
    required this.isActive,
    required this.onTap,
    Key? key,
  }) : super(key: key);
  final String number;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: isActive ? AppColors.mainColor : AppColors.dartBackground2,
            borderRadius: BorderRadius.circular(14)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.iDR,
              style: AppTextStyle.regular16.copyWith(
                color: AppColors.mainText.withOpacity(0.7),
              ),
            ),
            Text(
              number,
              style: AppTextStyle.regular16.copyWith(
                color: AppColors.mainText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
