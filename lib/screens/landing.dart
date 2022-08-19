import 'package:data/src/model/user.dart' as data;
import 'package:flutter/cupertino.dart';
import 'package:know_your_time/screens/auth/auth_screen.dart';
import 'package:provider/provider.dart';
import 'package:tracker_board_view/tracker_board_view.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data.User? user = Provider.of<data.User?>(context);
    final bool isLoggedIn = user != null;
    return isLoggedIn ? const TimeTrackingBoardScreen() : AuthorizationPage();
  }
}
