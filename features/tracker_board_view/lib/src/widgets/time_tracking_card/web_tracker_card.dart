import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import 'package:tracker_board_view/src/models/period_time_type.dart';
import 'package:tracker_board_view/src/widgets/hover_decorator.dart';
import 'package:tracker_board_view/src/widgets/time_tracking_card/builders/time_description_builder.dart';
import 'package:tracker_board_view/src/widgets/time_tracking_card/builders/tracker_card_background_color_builder.dart';
import 'package:tracker_board_view/src/widgets/time_tracking_card/builders/tracker_card_icon_asset_name_builder.dart';
import 'package:tracker_board_view/src/widgets/time_tracking_card/builders/tracker_card_title_builder.dart';

class WebTrackerCard extends StatelessWidget {
  final String categoryName;
  final List<Activity> currentActivityList;
  final List<Activity> previousActivityList;
  final PeriodTimeType periodTimeType;

  static const double _size = 168.0;

  const WebTrackerCard({
    required this.categoryName,
    required this.periodTimeType,
    required this.currentActivityList,
    required this.previousActivityList,
  });

  @override
  Widget build(BuildContext context) {
    return HoverDecorator(
      builder: (bool isHovered) {
        return ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(AppDimensions.borderRadius16),
          ),
          child: Stack(
            children: <Widget>[
              Container(
                width: _size,
                height: _size,
                color: buildTrackerCardBackgroundColor(categoryName),
              ),
              Positioned(
                right: 10,
                top: -12,
                child: RotationTransition(
                  turns: const AlwaysStoppedAnimation<double>(-10 / 360),
                  child: SizedBox.square(
                    dimension: 54.0,
                    child: SvgPicture.asset(
                      buildCardTrackingIconAssetName(categoryName),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(AppDimensions.padding24),
                  width: _size,
                  height: _size - 30,
                  decoration: BoxDecoration(
                    color: isHovered ? AppColors.onHover : AppColors.darkBlue,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(AppDimensions.borderRadius16),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            buildTrackingCardTitle(categoryName),
                            style: AppTextStyle.rubicRegular12,
                          ),
                          SvgPicture.asset(AppIcons.ellipsis, width: 14),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        '${_durationOfActivities(currentActivityList).inHours}${'timeTrackingBoardFeature.hours'.tr()}',
                        style: AppTextStyle.rubicLight28,
                      ),
                      const SizedBox(height: AppDimensions.padding6),
                      Text(
                        '${buildTimeDescription(periodTimeType)} - ${_durationOfActivities(previousActivityList).inHours}${'timeTrackingBoardFeature.hours'.tr()}',
                        style: AppTextStyle.rubicRegular10.copyWith(
                          color: AppColors.paleBlue,
                        ),
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

  static Duration _durationOfActivities(List<Activity> activities) {
    return activities.map((Activity act) => act.duration).fold(
        Duration(),
        (Duration previousValue, Duration element) =>
            Duration(seconds: previousValue.inSeconds + element.inSeconds));
  }
}
