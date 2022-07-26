import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:data/services/firebase_auth_service.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreenAccent,
      body: Align(
        child: Text(
          'Main Screen',
          style: AppTextStyle.rubicRegular20,
        ),
      ),
      appBar: AppBar(
        actions: <Widget>[
          TextButton.icon(
            onPressed: () {
              AuthService().signOut();
            },
            icon: Icon(
              Icons.supervised_user_circle,
              color: Colors.white,
            ),
            label: SizedBox.shrink(),
          )
        ],
      ),
    );
  }
}
