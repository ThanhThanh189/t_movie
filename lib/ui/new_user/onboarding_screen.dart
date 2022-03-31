import 'package:flutter/material.dart';
import 'package:movie_ticket/common/app_colors.dart';
import 'package:movie_ticket/common/icon_constraints.dart';
import 'package:movie_ticket/common/string_constraints.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dartBackground1,
        body: SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(32.6),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: Colors.blue),
                child: Image.asset(
                  IconContraints.iconFilm,
                  color: Colors.white,
                )),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'New Experience',
              style: StringConstraints.h1,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 70),
              child: const Text(
                'Watch a new movie much easier than any before',
                style: StringConstraints.h2,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue),
              child: const TextButton(
                onPressed: null,
                child: Text(
                  'Get Started',
                  style: StringConstraints.h2,
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
