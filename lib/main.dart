import 'package:domain/entities/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:know_your_time/screens/landing.dart';
import 'package:provider/provider.dart';
import 'package:data/services/firebase_auth_service.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserInno?>.value(
      value: AuthService().currentUser,
      initialData: null,
      child: MaterialApp(
          title: 'Know your time',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: LandingPage(),
        ),
    );
  }
}
