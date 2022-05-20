import 'package:flutter/material.dart';
import 'package:movie_ticket/common/app_colors.dart';
import 'package:movie_ticket/common/app_text_style.dart';

class DateTextField extends StatelessWidget {
  const DateTextField({
    required this.text,
    required this.onChange,
    required this.initialDate,
    Key? key,
  }) : super(key: key);

  final Function(DateTime) onChange;
  final String text;
  final DateTime initialDate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        DateTime? newSelectedDate = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
        );
        onChange(newSelectedDate ?? DateTime.now());
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(width: 0.5, color: AppColors.mainText),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: AppTextStyle.regular14.copyWith(
                color: AppColors.mainText,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_drop_down)
          ],
        ),
      ),
    );
  }
}
