import 'package:domain/domain.dart';
import 'package:tracker_board_view/src/bloc/tracker_board_bloc.dart';

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

class CheckOfflineMode implements TrackerBoardEvent {
  final bool isInternetAvailable;

  CheckOfflineMode({
    required this.isInternetAvailable,
  });
}

class GetUser implements TrackerBoardEvent {}

class Logout implements TrackerBoardEvent {}
