import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  AuthButton({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadius4),
        color: AppColors.white,
      ),
      height: 50,
      width: MediaQuery.of(context).size.width - 40,
      child: TextButton(
        onPressed: onTap,
        child: Text(
          label,
          style: AppTextStyle.rubicRegularLoginButton20,
        ),
      ),
    );
  }
}
