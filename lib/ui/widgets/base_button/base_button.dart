import 'package:flutter/material.dart';
import 'package:movie_ticket/common/app_colors.dart';
import 'package:movie_ticket/common/app_text_styles.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.isVisible,
  }) : super(key: key);

  final String text;
  final Function() onPressed;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isVisible ? AppColors.mainColor : AppColors.dartBackground2,
      ),
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
