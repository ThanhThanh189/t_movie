import 'package:flutter/material.dart';
import 'package:movie_ticket/common/app_colors.dart';
import 'package:movie_ticket/common/app_icons.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dartBackground1,
      body: SafeArea(
        child: Center(
          child: Container(
              padding: const EdgeInsets.all(32.6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32), color: Colors.blue),
              child: Image.asset(
                AppIcons.iconFilm,
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}
