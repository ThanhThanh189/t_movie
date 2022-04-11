import 'package:flutter/material.dart';
import 'package:movie_ticket/common/app_colors.dart';
import 'package:movie_ticket/common/app_text_style.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    Key? key,
    required this.controller,
    this.obscureText,
    this.errorText,
    this.onTapEyes,
    this.visibility,
    required this.onChange,
    required this.isPassword,
    this.labelText,
    this.hintText,
    this.readOnly,
  }) : super(key: key);
  final TextEditingController controller;
  final bool? obscureText;
  final String? errorText;
  final VoidCallback? onTapEyes;
  final bool isPassword;
  final bool? visibility;
  final String? labelText;
  final String? hintText;
  final bool? readOnly;
  final Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        controller: controller,
        style: AppTextStyle.regular14.copyWith(
          color: AppColors.mainText,
        ),
        readOnly: readOnly ?? false,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          labelStyle: AppTextStyle.regular14.copyWith(
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
          hintText: hintText,
          hintStyle: AppTextStyle.regular14.copyWith(
            color: AppColors.mainText,
          ),
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
