import 'package:core_ui/core_ui.dart';

String buildCardTrackingIconAssetName(String categoryName) {
  if (categoryName == 'work') {
    return AppIcons.work;
  }

  if (categoryName == 'play') {
    return AppIcons.play;
  }

  if (categoryName == 'study') {
    return AppIcons.study;
  }

  if (categoryName == 'exercise') {
    return AppIcons.exercise;
  }

  if (categoryName == 'social') {
    return AppIcons.social;
  }

  if (categoryName == 'self_care') {
    return AppIcons.selfCare;
  }

  return AppIcons.ellipsis;
}
