import '../models/period_time_type.dart';
import '../models/time_frame_filter.dart';

class TrackerBoardState {
  final bool isLoading;
  final PeriodTimeType periodTimeType;
  final TimeFrameFilter? timeFrameFilter;

  TrackerBoardState({
    required this.isLoading,
    required this.periodTimeType,
    required this.timeFrameFilter,
  });

  factory TrackerBoardState.initState() {
    return TrackerBoardState(
      isLoading: false,
      periodTimeType: PeriodTimeType.weekly,
      timeFrameFilter: null,
    );
  }

  TrackerBoardState copyWith({
    bool? isLoading,
    PeriodTimeType? periodTimeType,
    TimeFrameFilter? timeFrameFilter,
  }) {
    return TrackerBoardState(
      isLoading: isLoading ?? this.isLoading,
      periodTimeType: periodTimeType ?? this.periodTimeType,
      timeFrameFilter: timeFrameFilter ?? this.timeFrameFilter,
    );
  }
}
