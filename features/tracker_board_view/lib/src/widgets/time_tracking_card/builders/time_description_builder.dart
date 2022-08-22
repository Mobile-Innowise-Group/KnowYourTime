import 'package:core_ui/core_ui.dart';

import 'package:tracker_board_view/src/models/period_time_type.dart';

String buildTimeDescription(PeriodTimeType periodTimeType) {
  if (periodTimeType == PeriodTimeType.daily) {
    return 'timeTrackingBoardFeature.yesterday'.tr();
  }
  if (periodTimeType == PeriodTimeType.weekly) {
    return 'timeTrackingBoardFeature.lastWeek'.tr();
  }
  return 'timeTrackingBoardFeature.lastMonth'.tr();
}
