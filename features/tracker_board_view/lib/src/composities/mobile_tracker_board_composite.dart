import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:tracker_board_view/src/bloc/tracker_board_bloc.dart';
import 'package:tracker_board_view/src/widgets/profile_menu/mobile_profile_menu.dart';
import 'package:tracker_board_view/src/widgets/time_tracking_card/mobile_time_tracking_card.dart';

class MobileTimeTrackingBoardComposite extends StatefulWidget {
  final TrackerBoardState state;
  final User user;

  final void Function() onLogout;

  const MobileTimeTrackingBoardComposite({
    required this.state,
    required this.user,
    required this.onLogout,
  });

  @override
  _MobileTimeTrackingBoardCompositeState createState() =>
      _MobileTimeTrackingBoardCompositeState();
}

class _MobileTimeTrackingBoardCompositeState
    extends State<MobileTimeTrackingBoardComposite> {
  final Connectivity _connectivity = Connectivity();
  bool isInternetAvailable = false;

  @override
  void initState() {
    _connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.none) {
        setState(() {
          isInternetAvailable = false;
        });
      } else {
        setState(() {
          isInternetAvailable = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, PeriodActivities> mappedActivities = _groupByCategoryName(
      PeriodActivities(
        current: widget.state.currentPeriodActivities,
        previous: widget.state.previousPeriodActivities,
      ),
    );
    final List<String> categoryNames = mappedActivities.keys.toList();
    return Padding(
      padding: const EdgeInsets.only(
        left: AppDimensions.padding24,
        right: AppDimensions.padding24,
        top: AppDimensions.padding24,
      ),
      child: isInternetAvailable
          ? SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  MobileProfileMenu(
                    avatar: const AssetImage(AppImages.jeremy),
                    firstName: widget.user.fullName,
                    lastName: 'Popov',
                    selectedPeriodTimeType: widget.state.periodTimeType,
                    onDailyPressed: () {
                      BlocProvider.of<TrackerBoardBloc>(context, listen: false)
                          .add(
                        const PressDailyButton(),
                      );
                    },
                    onMonthlyPressed: () {
                      BlocProvider.of<TrackerBoardBloc>(context, listen: false)
                          .add(
                        const PressMonthlyButton(),
                      );
                    },
                    onWeeklyPressed: () {
                      BlocProvider.of<TrackerBoardBloc>(context, listen: false)
                          .add(
                        const PressWeeklyButton(),
                      );
                    },
                  ),
                  ...categoryNames.map(
                    (String catName) => Column(
                      children: <Widget>[
                        const SizedBox(height: AppDimensions.padding24),
                        MobileTrackerCard(
                          currentActivityList:
                              mappedActivities[catName]!.current,
                          previousActivityList:
                              mappedActivities[catName]!.previous,
                          periodTimeType: widget.state.periodTimeType,
                          categoryName: catName,
                        ),
                      ],
                    ),
                  ),
                  TextButton.icon(
                    onPressed: widget.onLogout,
                    icon: const Icon(Icons.logout, color: Colors.white),
                    label: Text(
                      'general.logout'.tr(),
                      style: AppTextStyle.rubicRegular20,
                    ),
                  )
                ],
              ),
            )
          : OfflineNotificationDialog(),
    );
  }

  Map<String, PeriodActivities> _groupByCategoryName(
      PeriodActivities periodActivities) {
    final Set<String> allCategoryNames = <List<Activity>>[
      periodActivities.previous,
      periodActivities.current,
    ]
        .expand((List<Activity> e) => e)
        .map((Activity act) => act.categoryName)
        .toSet();

    return Map<String, PeriodActivities>.fromIterable(
      allCategoryNames,
      value: (dynamic categoryName) => PeriodActivities(
        current: periodActivities.current
            .where((Activity act) => act.categoryName == categoryName)
            .toList(),
        previous: periodActivities.previous
            .where((Activity act) => act.categoryName == categoryName)
            .toList(),
      ),
    );
  }
}
