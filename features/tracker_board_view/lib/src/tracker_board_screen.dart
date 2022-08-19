import 'package:core_ui/core_ui.dart';
import 'package:di/di.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import 'package:tracker_board_view/src/bloc/tracker_board_bloc.dart';
import 'package:tracker_board_view/src/composities/mobile_tracker_board_composite.dart';
import 'package:tracker_board_view/src/composities/web_tracker_board_composite.dart';

class TimeTrackingBoardScreen extends StatelessWidget {
  const TimeTrackingBoardScreen();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TrackerBoardBloc>(
      create: (_) => TrackerBoardBloc(
        userRepository: appDependencies.get<UserRepository>(),
        activityRepository: appDependencies.get<ActivityRepository>(),
        authRepository: appDependencies.get<AuthRepository>(),
      )..add(GetUser()),
      child: const _TimeTrackingBoardScreen(),
    );
  }
}

class _TimeTrackingBoardScreen extends StatelessWidget {
  const _TimeTrackingBoardScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(backgroundColor: AppColors.veryDarkBlue),
      ),
      backgroundColor: AppColors.veryDarkBlue,
      body: BlocBuilder<TrackerBoardBloc, TrackerBoardState>(
        builder: (_, TrackerBoardState state) {
          final User? currentUser = state.currentUser;
          if (currentUser == null) {
            return const AppProgressIndicator();
          } else {
            return AdaptiveScreen(
              mobile: MobileTimeTrackingBoardComposite(
                state: state,
                user: currentUser,
                onLogout: () => _onLogout(context),
              ),
              web: WebTimeTrackingBoardComposite(
                state: state,
                user: currentUser,
                onLogout: () => _onLogout(context),
              ),
            );
          }
        },
      ),
    );
  }

  void _onLogout(BuildContext context) {
    context.read<TrackerBoardBloc>().add(Logout());
  }
}
