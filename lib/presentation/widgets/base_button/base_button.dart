import 'package:flutter/material.dart';
import 'package:movie_ticket/common/app_colors.dart';
import 'package:movie_ticket/common/app_text_style.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({
    Key? key,
    required this.text,
    this.onPressed,
    required this.isVisible,
    this.isExpanded = true,
  }) : super(key: key);

  final String text;
  final Function()? onPressed;
  final bool isVisible;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isExpanded ? double.infinity : null,
      padding: const EdgeInsets.symmetric(vertical: 3,horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isVisible ? AppColors.mainColor : AppColors.dartBackground2,
      ),
      child: TextButton(
        onPressed: isVisible ? onPressed : null,
        child: Text(
          text,
          style: AppTextStyle.medium18.copyWith(
            color: AppColors.mainText,
          ),
        ),
      ),
    );
  }
}
