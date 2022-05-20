import 'package:flutter/material.dart';
import 'package:movie_ticket/common/app_text_styles.dart';

class DialogImproving extends StatelessWidget {
  const DialogImproving({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: MediaQuery.of(context).size.height * 0.2,
        width: double.infinity,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(15.0),
              child: const Center(
                child: Text(
                  'The feature will be update',
                  style: AppTextStyles.h2BoldDark,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Icon(
                  Icons.cancel,
                  color: Colors.red,
                  size: 30,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
