import 'dart:async';

import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:tracker_board_view/src/bloc/tracker_board_event.dart';
import 'package:tracker_board_view/src/bloc/tracker_board_state.dart';
import 'package:tracker_board_view/src/models/period_time_type.dart';

export 'tracker_board_event.dart';
export 'tracker_board_state.dart';

class TrackerBoardBloc extends Bloc<TrackerBoardEvent, TrackerBoardState> {
  final ActivityRepository _activityRepository;
  final UserRepository _userRepository;
  final AuthRepository _authRepository;
  StreamSubscription<Future<List<Activity>>>? allActivitiesListener;

  TrackerBoardBloc({
    required AuthRepository authRepository,
    required UserRepository userRepository,
    required ActivityRepository activityRepository,
  })  : _activityRepository = activityRepository,
        _authRepository = authRepository,
        _userRepository = userRepository,
        super(TrackerBoardState.initState()) {
    on<PressDailyButton>(_onPressDailyButton);
    on<PressWeeklyButton>(_onPressWeeklyButton);
    on<PressMonthlyButton>(_onPressMonthlyButton);
    on<ActivitiesUpdated>(_onAllActivitiesUpdated);
    on<GetUser>(_onGetUser);
    on<Logout>(_onLogout);

    allActivitiesListener = _activityRepository.observeAll().listen(
      (Future<List<Activity>> eventActivities) async {
        add(
          ActivitiesUpdated(allActivities: await eventActivities),
        );
      },
    );
  }

  Future<void> _onPressDailyButton(
      PressDailyButton _, Emitter<TrackerBoardState> emit) async {
    const PeriodTimeType period = PeriodTimeType.daily;
    final PeriodActivities periodActivities =
        _filterByPeriod(period, state.allActivities);

    emit(
      state.copyWith(
        currentPeriodActivities: periodActivities.current,
        previousPeriodActivities: periodActivities.previous,
        periodTimeType: period,
      ),
    );
  }

  Future<void> _onPressWeeklyButton(
      PressWeeklyButton _, Emitter<TrackerBoardState> emit) async {
    const PeriodTimeType period = PeriodTimeType.weekly;
    final PeriodActivities periodActivities =
        _filterByPeriod(period, state.allActivities);

    emit(
      state.copyWith(
        currentPeriodActivities: periodActivities.current,
        previousPeriodActivities: periodActivities.previous,
        periodTimeType: period,
      ),
    );
  }

  Future<void> _onPressMonthlyButton(
      PressMonthlyButton _, Emitter<TrackerBoardState> emit) async {
    const PeriodTimeType period = PeriodTimeType.monthly;
    final PeriodActivities periodActivities =
        _filterByPeriod(period, state.allActivities);

    emit(
      state.copyWith(
        currentPeriodActivities: periodActivities.current,
        previousPeriodActivities: periodActivities.previous,
        periodTimeType: period,
      ),
    );
  }

  Future<void> _onAllActivitiesUpdated(
      ActivitiesUpdated event, Emitter<TrackerBoardState> emit) async {
    final PeriodTimeType period = state.periodTimeType;
    final PeriodActivities periodActivities =
        _filterByPeriod(period, event.allActivities);

    emit(
      state.copyWith(
        allActivities: event.allActivities,
        currentPeriodActivities: periodActivities.current,
        previousPeriodActivities: periodActivities.previous,
        periodTimeType: period,
      ),
    );
  }

  Future<void> _onGetUser(_, Emitter<TrackerBoardState> emit) async {
    emit(
      state.copyWith(
        currentUser: await _userRepository.getCurrent(),
      ),
    );
  }

  Future<void> _onLogout(_, Emitter<TrackerBoardState> emit) async {
    _authRepository.signOut();
  }

  PeriodActivities _filterByPeriod(
    PeriodTimeType periodTimeType,
    List<Activity> allActivities,
  ) {
    final DateTime now = DateTime.now();

    switch (periodTimeType) {
      case PeriodTimeType.daily:
        final DateTime yesterday = now.subtract(
          const Duration(days: 1),
        );

        return PeriodActivities(
          current: allActivities
              .where(
                (Activity activity) => activity.createdAt.isSameDayAs(now),
              )
              .toList(),
          previous: allActivities
              .where(
                (Activity activity) =>
                    activity.createdAt.isSameDayAs(yesterday),
              )
              .toList(),
        );

      case PeriodTimeType.weekly:
        final DateTime previousWeek = now.subtract(
          const Duration(days: 7),
        );

        return PeriodActivities(
          current: allActivities
              .where(
                (Activity activity) => activity.createdAt.isSameWeekAs(now),
              )
              .toList(),
          previous: allActivities
              .where(
                (Activity activity) =>
                    activity.createdAt.isSameWeekAs(previousWeek),
              )
              .toList(),
        );

      case PeriodTimeType.monthly:
        final DateTime previousMonthStart = DateTime(now.year, now.month - 1);

        return PeriodActivities(
          current: allActivities
              .where(
                (Activity activity) => activity.createdAt.isSameMonthAs(now),
              )
              .toList(),
          previous: allActivities
              .where(
                (Activity activity) =>
                    activity.createdAt.isSameMonthAs(previousMonthStart),
              )
              .toList(),
        );
    }
  }

  @override
  Future<void> close() async {
    allActivitiesListener?.cancel();
    allActivitiesListener = null;
    super.close();
  }
}

extension DateTimeExt on DateTime {
  bool isSameDayAs(DateTime other) {
    return day == other.day && month == other.month && year == other.year;
  }

  bool isSameWeekAs(DateTime other) {
    final DateTime startOfTheWeek = subtract(Duration(days: weekday - 1));
    final DateTime otherStartOfTheWeek = other.subtract(
      Duration(days: other.weekday - 1),
    );
    return startOfTheWeek.isSameDayAs(otherStartOfTheWeek);
  }

  bool isSameMonthAs(DateTime other) {
    return month == other.month && year == other.year;
  }
}

class PeriodActivities {
  final List<Activity> current;
  final List<Activity> previous;

  PeriodActivities({
    required this.current,
    required this.previous,
  });
}
