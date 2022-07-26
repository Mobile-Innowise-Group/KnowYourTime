import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';

import '../filters/filter.dart';
import '../models/period_time_type.dart';
import '../models/time_frame_filter.dart';
import 'tracker_board_event.dart';
import 'tracker_board_state.dart';

export 'tracker_board_event.dart';
export 'tracker_board_state.dart';

class TrackerBoardBloc
    extends Bloc<TrackerBoardEvent, TrackerBoardState> {
  final TimeFrameRepository _timeFrameRepository;
  late final TimeFrameList _timeFrameList;

  TrackerBoardBloc({
    required TimeFrameRepository timeFrameRepository,
  })  : _timeFrameRepository = timeFrameRepository,
        super(TrackerBoardState.initState()) {
    on<PressDailyButton>(_onPressDailyButton);
    on<PressWeeklyButton>(_onPressWeeklyButton);
    on<PressMonthlyButton>(_onPressMonthlyButton);
    on<LoadTimeFrames>(_onLoadTimeFrames);
  }

  Future<void> _onLoadTimeFrames(
      LoadTimeFrames _, Emitter<TrackerBoardState> emit) async {
    emit(state.copyWith(isLoading: true));
    _timeFrameList = await _timeFrameRepository.getTimeTracking();
    await _onPressDailyButton(const PressDailyButton(), emit);
  }

  Future<void> _onPressDailyButton(
      PressDailyButton _, Emitter<TrackerBoardState> emit) async {
    final TimeFrameFilter timeFrameFilter = applyTimeFrameFilter(
      periodTimeType: PeriodTimeType.daily,
      timeFrameList: _timeFrameList,
    );

    emit(
      state.copyWith(
        isLoading: false,
        periodTimeType: PeriodTimeType.daily,
        timeFrameFilter: timeFrameFilter,
      ),
    );
  }

  Future<void> _onPressWeeklyButton(
      PressWeeklyButton _, Emitter<TrackerBoardState> emit) async {
    final TimeFrameFilter timeFrameFilter = applyTimeFrameFilter(
      periodTimeType: PeriodTimeType.weekly,
      timeFrameList: _timeFrameList,
    );

    emit(
      state.copyWith(
        isLoading: false,
        periodTimeType: PeriodTimeType.weekly,
        timeFrameFilter: timeFrameFilter,
      ),
    );
  }

  Future<void> _onPressMonthlyButton(
      PressMonthlyButton _, Emitter<TrackerBoardState> emit) async {
    final TimeFrameFilter timeFrameFilter = applyTimeFrameFilter(
      periodTimeType: PeriodTimeType.monthly,
      timeFrameList: _timeFrameList,
    );

    emit(
      state.copyWith(
        isLoading: false,
        periodTimeType: PeriodTimeType.monthly,
        timeFrameFilter: timeFrameFilter,
      ),
    );
  }
}
