import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

import '../bloc/tracker_board_bloc.dart';
import '../models/tracker_card_type.dart';
import '../widgets/profile_menu/desktop_profile_menu.dart';
import '../widgets/time_tracking_card/desktop_tracker_card.dart';

class DesktopTimeTrackingBoardComposite extends StatelessWidget {
  final TrackerBoardState state;

  const DesktopTimeTrackingBoardComposite({
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            height: 360,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                DesktopProfileMenu(
                  avatar: const AssetImage(AppImages.jeremy),
                  firstName: 'Jeremy',
                  lastName: 'Robson',
                  selectedPeriodTimeType: state.periodTimeType,
                  onDailyPressed: () {
                    BlocProvider.of<TrackerBoardBloc>(context,
                            listen: false)
                        .add(const PressDailyButton());
                  },
                  onMonthlyPressed: () {
                    BlocProvider.of<TrackerBoardBloc>(context,
                            listen: false)
                        .add(const PressMonthlyButton());
                  },
                  onWeeklyPressed: () {
                    BlocProvider.of<TrackerBoardBloc>(context,
                            listen: false)
                        .add(const PressWeeklyButton());
                  },
                ),
                const SizedBox(width: AppDimensions.padding24),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        DesktopTrackerCard(
                          timeTrackingCardType: TrackerCardType.work,
                          currentHours:
                              state.timeFrameFilter?.work.current.toString() ??
                                  '',
                          previousHours:
                              state.timeFrameFilter?.work.previous.toString() ??
                                  '',
                          periodTimeType: state.periodTimeType,
                        ),
                        const SizedBox(width: AppDimensions.padding24),
                        DesktopTrackerCard(
                          timeTrackingCardType: TrackerCardType.play,
                          currentHours:
                              state.timeFrameFilter?.play.current.toString() ??
                                  '',
                          previousHours:
                              state.timeFrameFilter?.play.previous.toString() ??
                                  '',
                          periodTimeType: state.periodTimeType,
                        ),
                        const SizedBox(width: AppDimensions.padding24),
                        DesktopTrackerCard(
                          timeTrackingCardType: TrackerCardType.study,
                          currentHours:
                              state.timeFrameFilter?.study.current.toString() ??
                                  '',
                          previousHours: state.timeFrameFilter?.study.previous
                                  .toString() ??
                              '',
                          periodTimeType: state.periodTimeType,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.padding24),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        DesktopTrackerCard(
                          timeTrackingCardType: TrackerCardType.exercise,
                          currentHours: state.timeFrameFilter?.exercise.current
                                  .toString() ??
                              '',
                          previousHours: state
                                  .timeFrameFilter?.exercise.previous
                                  .toString() ??
                              '',
                          periodTimeType: state.periodTimeType,
                        ),
                        const SizedBox(width: AppDimensions.padding24),
                        DesktopTrackerCard(
                          timeTrackingCardType: TrackerCardType.social,
                          currentHours: state.timeFrameFilter?.social.current
                                  .toString() ??
                              '',
                          previousHours: state.timeFrameFilter?.social.previous
                                  .toString() ??
                              '',
                          periodTimeType: state.periodTimeType,
                        ),
                        const SizedBox(width: AppDimensions.padding24),
                        DesktopTrackerCard(
                          timeTrackingCardType: TrackerCardType.selfCare,
                          currentHours: state.timeFrameFilter?.selfCare.current
                                  .toString() ??
                              '',
                          previousHours: state
                                  .timeFrameFilter?.selfCare.previous
                                  .toString() ??
                              '',
                          periodTimeType: state.periodTimeType,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
