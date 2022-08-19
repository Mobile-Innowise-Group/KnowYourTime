import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import 'package:tracker_board_view/src/bloc/tracker_board_bloc.dart';
import 'package:tracker_board_view/src/widgets/profile_menu/web_profile_menu.dart';
import 'package:tracker_board_view/src/widgets/time_tracking_card/web_tracker_card.dart';

class WebTimeTrackingBoardComposite extends StatelessWidget {
  final TrackerBoardState state;
  final User user;

  final void Function() onLogout;

  const WebTimeTrackingBoardComposite({
    required this.state,
    required this.user,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, PeriodActivities> mappedActivities = _groupByCategoryName(
      PeriodActivities(
        current: state.currentPeriodActivities,
        previous: state.previousPeriodActivities,
      ),
    );
    final List<String> categoryNames = mappedActivities.keys.toList();
    return Center(
      child: SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            height: 400,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    WebProfileMenu(
                      avatar: const AssetImage(AppImages.jeremy),
                      firstName: user.fullName,
                      lastName: 'Popov',
                      selectedPeriodTimeType: state.periodTimeType,
                      onDailyPressed: () {
                        BlocProvider.of<TrackerBoardBloc>(context,
                                listen: false)
                            .add(
                          const PressDailyButton(),
                        );
                      },
                      onMonthlyPressed: () {
                        BlocProvider.of<TrackerBoardBloc>(context,
                                listen: false)
                            .add(
                          const PressMonthlyButton(),
                        );
                      },
                      onWeeklyPressed: () {
                        BlocProvider.of<TrackerBoardBloc>(context,
                                listen: false)
                            .add(
                          const PressWeeklyButton(),
                        );
                      },
                    ),
                    const SizedBox(height: AppDimensions.padding10),
                    TextButton.icon(
                      onPressed: onLogout,
                      icon: const Icon(Icons.logout, color: Colors.white),
                      label: Text(
                        'general.logout'.tr(),
                        style: AppTextStyle.rubicRegular20,
                      ),
                    )
                  ],
                ),
                const SizedBox(width: AppDimensions.padding24),
                Container(
                  width: 700,
                  height: 400,
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      ...categoryNames.map(
                        (String catName) => Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const SizedBox(
                              width: AppDimensions.padding20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: AppDimensions.padding20),
                              child: WebTrackerCard(
                                currentActivityList:
                                    mappedActivities[catName]!.current,
                                previousActivityList:
                                    mappedActivities[catName]!.previous,
                                periodTimeType: state.periodTimeType,
                                categoryName: catName,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
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
