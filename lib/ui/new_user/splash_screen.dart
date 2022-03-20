import 'package:flutter/material.dart';
import 'package:movie_ticket/common/icon_constraints.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
              padding: const EdgeInsets.all(32.6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32), color: Colors.blue),
              child: Image.asset(
                IconContraints.iconFilm,
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}
