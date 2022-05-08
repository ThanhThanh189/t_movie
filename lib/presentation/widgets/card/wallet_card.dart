import 'package:flutter/material.dart';
import 'package:movie_ticket/common/app_colors.dart';
import 'package:movie_ticket/common/app_strings.dart';
import 'package:movie_ticket/common/app_text_style.dart';

class WalletCard extends StatelessWidget {
  final String userName;
  final String iDCard;
  final int money;
  final bool isDark;
  const WalletCard(
      {Key? key,
      required this.userName,
      required this.iDCard,
      required this.money,
      required this.isDark})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height: 195,
            decoration: BoxDecoration(
                gradient:
                    isDark ? AppColors.mainGradient : AppColors.secondGradient,
                borderRadius: BorderRadius.circular(30.0))),
        Padding(
          padding: const EdgeInsets.only(left: 24, top: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.cardName,
                style: AppTextStyle.regular14
                    .copyWith(color: AppColors.mainText.withOpacity(0.7)),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                userName,
                style: AppTextStyle.semiBold16,
              ),
              const SizedBox(
                height: 28.0,
              ),
              Text(iDCard, style: AppTextStyle.medium12),
              const SizedBox(
                height: 28.0,
              ),
              Text('${AppStrings.iDR} $money', style: AppTextStyle.semiBold28)
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 50,
            top: 28,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 32.0,
                height: 32.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000.0),
                    color: isDark ? null : Colors.white.withOpacity(0.7),
                    gradient: isDark ? AppColors.secondGradient : null),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 25,
            top: 28,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 32.0,
                height: 32.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000.0),
                    color: isDark ? null : Colors.white,
                    gradient: isDark ? AppColors.secondGradient : null),
              )
            ],
          ),
        ),
      ],
    );
  }
}
