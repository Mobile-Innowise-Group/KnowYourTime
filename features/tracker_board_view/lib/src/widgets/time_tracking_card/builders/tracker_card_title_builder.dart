import 'package:core_ui/core_ui.dart';

String buildTrackingCardTitle(String categoryName) {
  const String notFoundLocalization = '-';

  if (categoryName == 'work') {
    return 'timeTrackingBoardFeature.work'.tr();
  }

  if (categoryName == 'play') {
    return 'timeTrackingBoardFeature.play'.tr();
  }

  if (categoryName == 'study') {
    return 'timeTrackingBoardFeature.study'.tr();
  }

  if (categoryName == 'exercise') {
    return 'timeTrackingBoardFeature.exercise'.tr();
  }

  if (categoryName == 'social') {
    return 'timeTrackingBoardFeature.social'.tr();
  }

  if (categoryName == 'self_care') {
    return 'timeTrackingBoardFeature.selfCare'.tr();
  }

  return notFoundLocalization;
}
