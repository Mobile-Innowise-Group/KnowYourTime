import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../../models/period_time_type.dart';
import '../../models/tracker_card_type.dart';
import '../hover_decorator.dart';
import 'builders/time_description_builder.dart';
import 'builders/tracker_card_background_color_builder.dart';
import 'builders/tracker_card_icon_asset_name_builder.dart';
import 'builders/tracker_card_title_builder.dart';

class MobileTrackerCard extends StatelessWidget {
  final TrackerCardType trackerCardType;
  final String currentHours;
  final String previousHours;
  final PeriodTimeType periodTimeType;

  static const double _height = 140.0;

  const MobileTrackerCard({
    required this.trackerCardType,
    required this.currentHours,
    required this.previousHours,
    required this.periodTimeType,
  });

  @override
  Widget build(BuildContext context) {
    return HoverDecorator(
      builder: (bool isHovered) {
        return ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(AppDimensions.borderRadius),
          ),
          child: Stack(
            children: <Widget>[
              Container(
                height: _height,
                color: buildTrackerCardBackgroundColor(trackerCardType),
              ),
              Positioned(
                right: 10,
                top: -12,
                child: RotationTransition(
                  turns: const AlwaysStoppedAnimation<double>(-10 / 360),
                  child: SizedBox.square(
                    dimension: 54.0,
                    child: SvgPicture.asset(
                      buildCardTrackingIconAssetName(trackerCardType),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(AppDimensions.padding24),
                  height: _height - 30,
                  decoration: BoxDecoration(
                      color: isHovered ? AppColors.onHover : AppColors.darkBlue,
                      borderRadius: const BorderRadius.all(
                          Radius.circular(AppDimensions.borderRadius))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            buildTrackingCardTitle(trackerCardType),
                            style: AppTextStyle.rubicRegular12,
                          ),
                          SvgPicture.asset(AppIcons.ellipsis, width: 14),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '$currentHours${'timeTrackingBoardFeature.hours'.tr()}',
                            style: AppTextStyle.rubicLight28,
                          ),
                          const SizedBox(height: AppDimensions.padding6),
                          Text(
                            '${buildTimeDescription(periodTimeType)} - $previousHours${'timeTrackingBoardFeature.hours'.tr()}',
                            style: AppTextStyle.rubicRegular10.copyWith(
                              color: AppColors.paleBlue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
