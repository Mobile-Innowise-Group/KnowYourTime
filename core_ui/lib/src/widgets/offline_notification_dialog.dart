import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

class OfflineNotificationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog(
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              AppDimensions.padding10,
            ),
          ),
        ),
        child: Container(
          height: AppDimensions.padding80,
          width: AppDimensions.padding100,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.white,
              width: 2,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(
                AppDimensions.padding10,
              ),
            ),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(
                  AppDimensions.padding10,
                ),
                child: Text(
                  'general.no_internet_connection'.tr(),
                  style: AppTextStyle.rubicRegular12.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: AppDimensions.padding10,
              ),
              const Icon(
                Icons.network_locked,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
