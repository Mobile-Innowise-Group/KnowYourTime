import 'package:core_ui/core_ui.dart';

import '../../../models/tracker_card_type.dart';

String buildCardTrackingIconAssetName(TrackerCardType trackerCardType) {
  if (trackerCardType == TrackerCardType.work) {
    return AppIcons.work;
  }

  if (trackerCardType == TrackerCardType.play) {
    return AppIcons.play;
  }

  if (trackerCardType == TrackerCardType.study) {
    return AppIcons.study;
  }

  if (trackerCardType == TrackerCardType.exercise) {
    return AppIcons.exercise;
  }

  if (trackerCardType == TrackerCardType.social) {
    return AppIcons.social;
  }

  if (trackerCardType == TrackerCardType.selfCare) {
    return AppIcons.selfCare;
  }

  return AppIcons.ellipsis;
}
