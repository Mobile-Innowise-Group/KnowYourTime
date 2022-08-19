import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:know_your_time/screens/auth/bloc/auth_bloc.dart';
import 'package:know_your_time/screens/auth/bloc/auth_state.dart';
import 'package:know_your_time/screens/auth/mobile_auth_screen.dart';
import 'package:know_your_time/screens/auth/web_auth_screen.dart';

class AuthorizationPage extends StatelessWidget {
  AuthorizationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(
        authRepository: serviceLocator.get<AuthRepository>(),
      ),
      child: const _AuthorizationPage(),
    );
  }
}

class _AuthorizationPage extends StatelessWidget {
  const _AuthorizationPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return AdaptiveScreen(
            mobile: MobileAuthorizationPage(),
            desktop: WebAuthorizationPage(),
          );
        },
      ),
    );
  }
}
