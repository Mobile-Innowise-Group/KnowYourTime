import 'package:domain/entities/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:know_your_time/screens/auth_screen.dart';
import 'package:know_your_time/screens/main_screen.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserInno? user = Provider.of<UserInno?>(context);
    final bool isLoggedIn = user != null;
    return isLoggedIn ? MainPage() : AuthorizationPage();
  }
}
