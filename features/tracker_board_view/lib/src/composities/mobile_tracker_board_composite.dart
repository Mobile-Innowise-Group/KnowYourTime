import 'package:core_ui/core_ui.dart';
import 'package:data/src/services/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:tracker_board_view/src/bloc/tracker_board_bloc.dart';
import 'package:tracker_board_view/src/models/tracker_card_type.dart';
import 'package:tracker_board_view/src/widgets/profile_menu/mobile_profile_menu.dart';
import 'package:tracker_board_view/src/widgets/time_tracking_card/mobile_time_tracking_card.dart';

class MobileTimeTrackingBoardComposite extends StatelessWidget {
  final TrackerBoardState state;

  const MobileTimeTrackingBoardComposite({
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppDimensions.padding24,
        right: AppDimensions.padding24,
        top: AppDimensions.padding24,
      ),
      child: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 330),
            child: Column(
              children: <Widget>[
                MobileProfileMenu(
                  avatar: const AssetImage(AppImages.jeremy),
                  firstName: 'Jeremy',
                  lastName: 'Robson',
                  selectedPeriodTimeType: state.periodTimeType,
                  onDailyPressed: () {
                    BlocProvider.of<TrackerBoardBloc>(context, listen: false)
                        .add(const PressDailyButton());
                  },
                  onMonthlyPressed: () {
                    BlocProvider.of<TrackerBoardBloc>(context, listen: false)
                        .add(const PressMonthlyButton());
                  },
                  onWeeklyPressed: () {
                    BlocProvider.of<TrackerBoardBloc>(context, listen: false)
                        .add(const PressWeeklyButton());
                  },
                ),
                const SizedBox(height: AppDimensions.padding24),
                MobileTrackerCard(
                  trackerCardType: TrackerCardType.work,
                  currentHours:
                      state.timeFrameFilter?.work.current.toString() ?? '',
                  previousHours:
                      state.timeFrameFilter?.work.previous.toString() ?? '',
                  periodTimeType: state.periodTimeType,
                ),
                const SizedBox(height: AppDimensions.padding24),
                MobileTrackerCard(
                  trackerCardType: TrackerCardType.play,
                  currentHours:
                      state.timeFrameFilter?.play.current.toString() ?? '',
                  previousHours:
                      state.timeFrameFilter?.play.previous.toString() ?? '',
                  periodTimeType: state.periodTimeType,
                ),
                const SizedBox(height: AppDimensions.padding24),
                MobileTrackerCard(
                  trackerCardType: TrackerCardType.study,
                  currentHours:
                      state.timeFrameFilter?.study.current.toString() ?? '',
                  previousHours:
                      state.timeFrameFilter?.study.previous.toString() ?? '',
                  periodTimeType: state.periodTimeType,
                ),
                const SizedBox(height: AppDimensions.padding24),
                MobileTrackerCard(
                  trackerCardType: TrackerCardType.exercise,
                  currentHours:
                      state.timeFrameFilter?.exercise.current.toString() ?? '',
                  previousHours:
                      state.timeFrameFilter?.exercise.previous.toString() ?? '',
                  periodTimeType: state.periodTimeType,
                ),
                const SizedBox(height: AppDimensions.padding24),
                MobileTrackerCard(
                  trackerCardType: TrackerCardType.social,
                  currentHours:
                      state.timeFrameFilter?.social.current.toString() ?? '',
                  previousHours:
                      state.timeFrameFilter?.social.previous.toString() ?? '',
                  periodTimeType: state.periodTimeType,
                ),
                const SizedBox(height: AppDimensions.padding24),
                MobileTrackerCard(
                  trackerCardType: TrackerCardType.selfCare,
                  currentHours:
                      state.timeFrameFilter?.selfCare.current.toString() ?? '',
                  previousHours:
                      state.timeFrameFilter?.selfCare.previous.toString() ?? '',
                  periodTimeType: state.periodTimeType,
                ),
                TextButton.icon(
                  onPressed: () {
                    AuthService().signOut();
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  label: Text(
                    'general.logout'.tr(),
                    style: AppTextStyle.rubicRegular20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
