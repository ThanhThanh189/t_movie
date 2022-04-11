import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_ticket/common/app_colors.dart';
import 'package:movie_ticket/common/app_icons.dart';
import 'package:movie_ticket/presentation/authentication_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState()  {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const AuthenticationScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dartBackground1,
      body: Center(
        child: Container(
            padding: const EdgeInsets.all(32.6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32), color: Colors.blue),
            child: Image.asset(
              AppIcons.iconFilm,
              color: Colors.white,
            )),
      ),
    );
  }
}
