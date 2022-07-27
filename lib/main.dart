import 'package:core_ui/core_ui.dart';
import 'package:data/data.dart';
import 'package:data/src/services/firebase_auth_service.dart';
import 'package:domain/src/entities/user/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:know_your_time/screens/landing.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DataDI.initDependencies();
  runApp(
    EasyLocalization(
      supportedLocales: const <Locale>[
        Locale('en', 'US'),
      ],
      fallbackLocale: const Locale('en', 'US'),
      path: 'assets/translations',
      child: const _TimeFrameApp(),
    ),
  );
}

class _TimeFrameApp extends StatelessWidget {
  const _TimeFrameApp();

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
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: LandingPage(),
      ),
    );
  }
}
