import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class InputBar extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final String? Function(String?)? validator;
  final bool obscure;
  final int maxLength;

  InputBar({
    required this.hintText,
    required this.textEditingController,
    required this.validator,
    required this.obscure,
    required this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      validator: validator,
      controller: textEditingController,
      obscureText: obscure,
      style: AppTextStyle.rubicRegular20,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 8,
        ),
        counterText: '',
        hintStyle: AppTextStyle.rubicRegularHint20,
        hintText: hintText,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.white,
            width: 3,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.red,
            width: 1,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.red,
            width: 1,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.white54,
            width: 1,
          ),
        ),
      ),
    );
  }
}
