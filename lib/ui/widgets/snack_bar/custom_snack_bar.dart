import 'package:flutter/material.dart';
import 'package:movie_ticket/common/app_text_style.dart';

class CustomSnackBar extends SnackBar {
  CustomSnackBar({
    Key? key,
    required String message,
    bool? isSuccess,
    required int milliseconds,
  }) : super(
          key: key,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                isSuccess == null
                    ? null
                    : isSuccess == true
                        ? Icons.check_circle
                        : Icons.cancel,
                color: isSuccess == null
                    ? Colors.blue
                    : isSuccess == true
                        ? Colors.green
                        : Colors.red,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  message,
                  style: AppTextStyle.medium14,
                ),
              ),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1000),
          ),
          duration: Duration(milliseconds: milliseconds),
          backgroundColor: Colors.white,
        );
}
