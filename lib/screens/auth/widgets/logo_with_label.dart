import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class LogoWithLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/images/calendar_icon.png',
            width: AppDimensions.imageSize40,
            height: AppDimensions.imageSize40,
          ),
          const SizedBox(width: 10),
          Text(
            'general.label_uppercase'.tr(),
            style: AppTextStyle.rubicRegularMobileLabel,
          ),
        ],
      ),
    );
  }
}
