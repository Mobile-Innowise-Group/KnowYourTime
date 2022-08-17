import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:know_your_time/screens/auth/bloc/auth_bloc.dart';
import 'package:know_your_time/screens/auth/bloc/auth_event.dart';
import 'package:know_your_time/screens/auth/bloc/auth_state.dart';

class DesktopAuthorizationPage extends StatelessWidget {
  DesktopAuthorizationPage({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(
        authRepository: serviceLocator.get<AuthRepository>(),
      ),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: AppColors.darkBlue,
            body: Column(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _logoWithLabel,
                  ],
                ),
                const SizedBox(height: 20),
                state.isUserRegistered
                    ? Column(
                        children: <Widget>[
                          _authForm(
                            label: 'general.login_uppercase'.tr(),
                            context: context,
                            func: () {
                              context.read<AuthBloc>().add(
                                    SignInWithEmailAndPasswordEvent(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    ),
                                  );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(
                              AppDimensions.padding20,
                            ),
                            child: GestureDetector(
                              child: Text(
                                'general.not_registered'.tr(),
                                style: AppTextStyle.rubicRegular20,
                              ),
                              onTap: () {
                                context.read<AuthBloc>().add(
                                      UpdateUserRegistrationStatusEvent(
                                        isUserRegister: false,
                                      ),
                                    );
                              },
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: <Widget>[
                          _authForm(
                            label: 'general.register_uppercase'.tr(),
                            context: context,
                            func: () {
                              context.read<AuthBloc>().add(
                                    RegisterWithEmailAndPasswordEvent(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    ),
                                  );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(
                              AppDimensions.padding20,
                            ),
                            child: GestureDetector(
                              child: Text(
                                'general.already_registered'.tr(),
                                style: AppTextStyle.rubicRegular20,
                              ),
                              onTap: () {
                                context.read<AuthBloc>().add(
                                      UpdateUserRegistrationStatusEvent(
                                        isUserRegister: true,
                                      ),
                                    );
                              },
                            ),
                          ),
                        ],
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.borderRadius16,
                        ),
                        color: AppColors.white,
                      ),
                      child: IconButton(
                        onPressed: () => context.read<AuthBloc>().add(
                              SignInWithGoogleEvent(),
                            ),
                        icon: Image.asset(
                          'assets/images/google_icon.png',
                          height: AppDimensions.imageSize60,
                          width: AppDimensions.imageSize60,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.borderRadius16,
                        ),
                        color: AppColors.white,
                      ),
                      child: IconButton(
                        onPressed: () => context.read<AuthBloc>().add(
                              SignInWithAppleEvent(),
                            ),
                        icon: Image.asset(
                          'assets/images/apple_logo.png',
                          height: AppDimensions.imageSize60,
                          width: AppDimensions.imageSize60,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          AppDimensions.borderRadius16,
                        ),
                        color: AppColors.white,
                      ),
                      child: IconButton(
                        onPressed: () => context.read<AuthBloc>().add(
                              SignInWithFacebookEvent(),
                            ),
                        icon: Image.asset(
                          'assets/images/facebook_logo.png',
                          height: AppDimensions.imageSize60,
                          width: AppDimensions.imageSize60,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget get _logoWithLabel {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppDimensions.padding24,
        top: AppDimensions.padding60,
        bottom: AppDimensions.padding20,
      ),
      child: Align(
        child: Row(
          children: [
            Image.asset(
              'assets/images/calendar_icon.png',
              width: AppDimensions.imageSize60,
              height: AppDimensions.imageSize60,
            ),
            const SizedBox(width: 10),
            Text(
              'general.label_uppercase'.tr(),
              style: AppTextStyle.rubicRegularWebLabel,
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputBar(
    Icon icon,
    String hintText,
    TextEditingController textEditingController,
    bool obscure,
  ) {
    return Container(
      width: 400,
      height: 40,
      child: TextField(
        controller: textEditingController,
        obscureText: obscure,
        style: AppTextStyle.rubicRegular20,
        decoration: InputDecoration(
          hintStyle: AppTextStyle.rubicRegularHint15,
          hintText: hintText,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.white,
              width: 3,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.white54,
              width: 1,
            ),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.padding6,
            ),
            child: IconTheme(
              child: icon,
              data: const IconThemeData(
                color: AppColors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _authForm({
    required String label,
    required BuildContext context,
    required VoidCallback func,
  }) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
            top: AppDimensions.padding10,
            bottom: AppDimensions.padding20,
          ),
          child: _inputBar(
            const Icon(Icons.email),
            'general.email_uppercase'.tr(),
            _emailController,
            false,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: AppDimensions.padding20,
          ),
          child: _inputBar(
            const Icon(Icons.lock),
            'general.password_uppercase'.tr(),
            _passwordController,
            true,
          ),
        ),
        const SizedBox(height: AppDimensions.padding20),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimensions.borderRadius4),
            color: AppColors.white,
          ),
          height: 36,
          width: 400,
          child: _loginButton(label, func),
        ),
      ],
    );
  }

  Widget _loginButton(String textLabel, VoidCallback onTap) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        textLabel,
        style: AppTextStyle.rubicRegularLoginButton20,
      ),
    );
  }
}
