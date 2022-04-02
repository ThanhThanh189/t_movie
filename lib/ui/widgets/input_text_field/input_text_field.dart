import 'package:flutter/material.dart';
import 'package:movie_ticket/common/app_colors.dart';
import 'package:movie_ticket/common/app_text_styles.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    Key? key,
    required this.controller,
    this.obscureText,
    required this.errorText,
    this.onTapEyes,
    this.visibility,
    required this.onChange,
    required this.isPassword,
    required this.labelText,
  }) : super(key: key);
  final TextEditingController controller;
  final bool? obscureText;
  final String? errorText;
  final VoidCallback? onTapEyes;
  final bool isPassword;
  final bool? visibility;
  final String labelText;
  final Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        controller: controller,
        style: AppTextStyles.regular14.copyWith(
          color: AppColors.mainText,
        ),
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          labelStyle: AppTextStyles.regular14.copyWith(
            color: AppColors.mainText,
          ),
          errorText: errorText,
          suffixIcon: isPassword
              ? GestureDetector(
                  onTap: onTapEyes,
                  child: visibility == true
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                )
              : null,
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: null,
        onChanged: onChange,
      ),
    );
  }
}
