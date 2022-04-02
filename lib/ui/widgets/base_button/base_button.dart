import 'package:flutter/material.dart';
import 'package:movie_ticket/common/app_colors.dart';
import 'package:movie_ticket/common/app_text_styles.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: AppColors.mainColor),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: AppTextStyles.medium18.copyWith(
            color: AppColors.mainText,
          ),
        ),
      ),
    );
  }
}
