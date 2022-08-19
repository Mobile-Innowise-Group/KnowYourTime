import 'package:domain/domain.dart';

abstract class TrackerBoardEvent {
  const TrackerBoardEvent();
}

class ActivitiesUpdated implements TrackerBoardEvent {
  final List<Activity> allActivities;

  ActivitiesUpdated({required this.allActivities});
}

class PressDailyButton implements TrackerBoardEvent {
  const PressDailyButton();
}

class PressWeeklyButton implements TrackerBoardEvent {
  const PressWeeklyButton();
}

class PressMonthlyButton implements TrackerBoardEvent {
  const PressMonthlyButton();
}

class GetUser implements TrackerBoardEvent {}

class Logout implements TrackerBoardEvent {}
