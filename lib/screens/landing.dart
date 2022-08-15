import 'package:domain/src/entities/user/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:know_your_time/screens/auth/auth_screen.dart';
import 'package:provider/provider.dart';
import 'package:tracker_board_view/tracker_board_view.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserInno? user = Provider.of<UserInno?>(context);
    final bool isLoggedIn = user != null;
    return isLoggedIn ? const TimeTrackingBoardScreen() : AuthorizationPage();
  }
}
