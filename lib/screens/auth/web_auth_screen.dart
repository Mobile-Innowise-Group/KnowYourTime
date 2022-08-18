import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:know_your_time/screens/auth/bloc/auth_bloc.dart';
import 'package:know_your_time/screens/auth/bloc/auth_event.dart';
import 'package:know_your_time/screens/auth/bloc/auth_state.dart';
import 'package:know_your_time/screens/auth/widgets/auth_form/login_form.dart';
import 'package:know_your_time/screens/auth/widgets/auth_form/registration_form.dart';
import 'package:know_your_time/screens/auth/widgets/logo_with_label.dart';

class WebAuthorizationPage extends StatelessWidget {
  WebAuthorizationPage({Key? key}) : super(key: key);

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
                const Spacer(),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      LogoWithLabel(),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                state.isUserRegistered
                    ? Expanded(
                        flex: 10,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 500),
                          child: Column(
                            children: <Widget>[
                              LoginForm(
                                label: 'general.login_uppercase'.tr(),
                                context: context,
                                onTap: (String email, String password) {
                                  context.read<AuthBloc>().add(
                                        SignInWithEmailAndPasswordEvent(
                                          email: email,
                                          password: password,
                                        ),
                                      );
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: AppDimensions.padding20,
                                ),
                                child: GestureDetector(
                                  child: Text(
                                    'general.not_registered'.tr(),
                                    style: AppTextStyle.rubicItalic20,
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
                                      onPressed: () =>
                                          context.read<AuthBloc>().add(
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
                                      onPressed: () =>
                                          context.read<AuthBloc>().add(
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
                                      onPressed: () =>
                                          context.read<AuthBloc>().add(
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
                        ),
                      )
                    : Expanded(
                        flex: 10,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 500),
                          child: Column(
                            children: <Widget>[
                              RegistrationForm(
                                label: 'general.register_uppercase'.tr(),
                                context: context,
                                onTap: (String email, String password,
                                    String firstName, String lastName) {
                                  context.read<AuthBloc>().add(
                                        RegisterWithEmailAndPasswordEvent(
                                          email: email,
                                          password: password,
                                          firstName: firstName,
                                          lastName: lastName,
                                        ),
                                      );
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: AppDimensions.padding20,
                                ),
                                child: GestureDetector(
                                  child: Text(
                                    'general.already_registered'.tr(),
                                    style: AppTextStyle.rubicItalic20,
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
                                      onPressed: () =>
                                          context.read<AuthBloc>().add(
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
                                      onPressed: () =>
                                          context.read<AuthBloc>().add(
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
                                      onPressed: () =>
                                          context.read<AuthBloc>().add(
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
                        ),
                      ),
                const Spacer(),
              ],
            ),
          );
        },
      ),
    );
  }
}
