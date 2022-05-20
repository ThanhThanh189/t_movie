import 'package:flutter/material.dart';
import 'package:movie_ticket/common/app_colors.dart';
import 'package:movie_ticket/common/app_icons.dart';

class NextButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isSlected;
  const NextButton({Key? key, required this.onTap, required this.isSlected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isSlected ? onTap : null,
      child: Center(
        child: Container(
          margin: const EdgeInsets.only(top: 40.0),
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1000),
          ),
          child: CircleAvatar(
            backgroundColor:
                isSlected ? AppColors.mainColor : AppColors.greyBackground1,
            child: Image.asset(
              AppIcons.iconNext,
              width: 30.0,
              height: 30.0,
            ),
          ),
        ),
      ),
    );
  }
}
