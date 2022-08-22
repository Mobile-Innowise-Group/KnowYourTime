import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';

import 'package:tracker_board_view/src/models/period_time_type.dart';

class TrackerBoardState extends Equatable {
  final PeriodTimeType periodTimeType;
  final List<Activity> allActivities;
  final List<Activity> currentPeriodActivities;
  final List<Activity> previousPeriodActivities;

  final User? currentUser;

  const TrackerBoardState({
    required this.periodTimeType,
    required this.allActivities,
    required this.currentPeriodActivities,
    required this.previousPeriodActivities,
    required this.currentUser,
  });

  factory TrackerBoardState.initState() {
    return const TrackerBoardState(
      periodTimeType: PeriodTimeType.daily,
      allActivities: <Activity>[],
      currentPeriodActivities: <Activity>[],
      previousPeriodActivities: <Activity>[],
      currentUser: null,
    );
  }

  TrackerBoardState copyWith({
    PeriodTimeType? periodTimeType,
    List<Activity>? currentPeriodActivities,
    List<Activity>? previousPeriodActivities,
    List<Activity>? allActivities,
    User? currentUser,
  }) {
    return TrackerBoardState(
      periodTimeType: periodTimeType ?? this.periodTimeType,
      allActivities: allActivities ?? this.allActivities,
      previousPeriodActivities:
          previousPeriodActivities ?? this.previousPeriodActivities,
      currentPeriodActivities:
          currentPeriodActivities ?? this.currentPeriodActivities,
      currentUser: currentUser ?? this.currentUser,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        currentPeriodActivities,
        currentUser,
        previousPeriodActivities,
        allActivities,
        periodTimeType,
      ];
}
