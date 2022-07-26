import 'package:core_ui/core_ui.dart';

import '../../../models/tracker_card_type.dart';

String buildTrackingCardTitle(TrackerCardType trackerCardType) {
  const String notFoundLocalization = '-';

  if (trackerCardType == TrackerCardType.work) {
    return 'timeTrackingBoardFeature.work'.tr();
  }

  if (trackerCardType == TrackerCardType.play) {
    return 'timeTrackingBoardFeature.play'.tr();
  }

  if (trackerCardType == TrackerCardType.study) {
    return 'timeTrackingBoardFeature.study'.tr();
  }

  if (trackerCardType == TrackerCardType.exercise) {
    return 'timeTrackingBoardFeature.exercise'.tr();
  }

  if (trackerCardType == TrackerCardType.social) {
    return 'timeTrackingBoardFeature.social'.tr();
  }

  if (trackerCardType == TrackerCardType.selfCare) {
    return 'timeTrackingBoardFeature.selfCare'.tr();
  }

  return notFoundLocalization;
}
