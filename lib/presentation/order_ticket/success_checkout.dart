import 'package:flutter/material.dart';
import 'package:movie_ticket/common/app_colors.dart';
import 'package:movie_ticket/common/app_images.dart';
import 'package:movie_ticket/common/app_strings.dart';
import 'package:movie_ticket/common/app_text_style.dart';
import 'package:movie_ticket/presentation/widgets/base_button/base_button.dart';

class SuccessCheckout extends StatelessWidget {
  const SuccessCheckout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.dartBackground1,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 200,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 120,
                  ),
                  Image.asset(
                    AppImages.checkoutSuccess,
                    width: 250,
                    height: 250,
                  )
                ],
              ),
              Text(
                AppStrings.happyWatching,
                style: AppTextStyle.medium24,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                AppStrings.successfuly,
                style: AppTextStyle.light18
                    .copyWith(color: Colors.white.withOpacity(0.8)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 70,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: BaseButton(
                  text: AppStrings.myHome,
                  isVisible: true,
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
