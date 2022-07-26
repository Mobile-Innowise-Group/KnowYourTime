
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../../../models/tracker_card_type.dart';

Color buildTrackerCardBackgroundColor(TrackerCardType trackerCardType) {
  if (trackerCardType == TrackerCardType.work) {
    return AppColors.lightRedWork;
  }

  if (trackerCardType == TrackerCardType.play) {
    return AppColors.softBluePlay;
  }

  if (trackerCardType == TrackerCardType.study) {
    return AppColors.lightRedStudy;
  }

  if (trackerCardType == TrackerCardType.exercise) {
    return AppColors.limeGreenExercise;
  }

  if (trackerCardType == TrackerCardType.social) {
    return AppColors.violetSocial;
  }

  if (trackerCardType == TrackerCardType.selfCare) {
    return AppColors.softOrangeSelfCare;
  }

  return Colors.white;
}
