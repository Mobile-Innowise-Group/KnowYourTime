import 'package:flutter/material.dart';

import '../../core_ui.dart';

class AppTextStyle {
  static const String _rubicFamily = 'Rubic';
  static const Color _textColor = AppColors.textColor;
  static const Color _textHintColor = AppColors.textHintColor;
  static const Color _textLoginButtonColor = AppColors.darkBlue;

  static const TextStyle rubicRegular10 = TextStyle(
    fontFamily: _rubicFamily,
    fontWeight: FontWeight.w400,
    fontSize: 10.0,
    color: _textColor,
  );

  static const TextStyle rubicRegular12 = TextStyle(
    fontFamily: _rubicFamily,
    fontWeight: FontWeight.w400,
    fontSize: 12.0,
    color: _textColor,
  );

  static const TextStyle rubicRegular20 = TextStyle(
    fontFamily: _rubicFamily,
    fontWeight: FontWeight.w400,
    fontSize: 20.0,
    color: _textColor,
  );

  static const TextStyle rubicRegularHint20 = TextStyle(
    fontFamily: _rubicFamily,
    fontWeight: FontWeight.w400,
    fontSize: 20.0,
    color: _textHintColor,
  );

  static const TextStyle rubicRegularLoginButton20 = TextStyle(
    fontFamily: _rubicFamily,
    fontWeight: FontWeight.w600,
    fontSize: 20.0,
    color: _textLoginButtonColor,
  );

  static const TextStyle rubicLight28 = TextStyle(
    fontFamily: _rubicFamily,
    fontWeight: FontWeight.w300,
    fontSize: 28.0,
    color: _textColor,
  );
}
