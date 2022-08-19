import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

Color buildTrackerCardBackgroundColor(String categoryName) {
  if (categoryName == 'work') {
    return AppColors.lightRedWork;
  }

  if (categoryName == 'play') {
    return AppColors.softBluePlay;
  }

  if (categoryName == 'study') {
    return AppColors.lightRedStudy;
  }

  if (categoryName == 'exercise') {
    return AppColors.limeGreenExercise;
  }

  if (categoryName == 'social') {
    return AppColors.violetSocial;
  }

  if (categoryName == 'self_care') {
    return AppColors.softOrangeSelfCare;
  }

  return AppColors.white;
}
