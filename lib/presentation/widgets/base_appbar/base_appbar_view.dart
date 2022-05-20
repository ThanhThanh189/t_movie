import 'package:flutter/material.dart';
import 'package:movie_ticket/common/app_text_style.dart';

class BaseAppBarView extends StatelessWidget {
  const BaseAppBarView({
    required this.title,
    this.showBack = true,
    required this.onBackTap,
    Key? key,
  }) : super(key: key);
  final String title;
  final bool showBack;
  final VoidCallback onBackTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showBack)
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: GestureDetector(
              onTap: onBackTap,
              child: const Icon(
                Icons.arrow_back,
                size: 30,
              ),
            ),
          ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 55.0),
            child: Text(
              title,
              style: AppTextStyle.semiBold24,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}
