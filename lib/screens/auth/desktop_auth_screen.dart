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
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();
  final _registerFormKey = GlobalKey<FormState>();

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
                          _loginForm(
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
                        ],
                      )
                    : Column(
                        children: <Widget>[
                          _registerForm(
                            label: 'general.register_uppercase'.tr(),
                            context: context,
                            func: () {
                              context.read<AuthBloc>().add(
                                    RegisterWithEmailAndPasswordEvent(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                      firstName: _firstNameController.text,
                                      lastName: _lastNameController.text,
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

  String? Function(String?)? get _emailValidator {
    return (text) {
      if (text == null || text.isEmpty) {
        return 'Can\'t be empty';
      }
      if (text.length < 4) {
        return 'Too short';
      }
      return null;
    };
  }

  String? Function(String?)? get _passwordValidator {
    return (text) {
      if (text == null || text.isEmpty) {
        return 'Can\'t be empty';
      } else if (text.length < 8) {
        return 'Too short';
      } else if (text.contains('@')) {
        return 'Please don\'t use the @ char.';
      }
      return null;
    };
  }

  String? Function(String?)? get _nameValidator {
    return (text) {
      if (text == null || text.isEmpty) {
        return 'Can\'t be empty';
      } else if (text.length < 3) {
        return 'Too short';
      } else if (text.contains('@')) {
        return 'Please don\'t use the @ char.';
      }
      return null;
    };
  }

  Widget _inputBar(
    String hintText,
    TextEditingController textEditingController,
    String? Function(String?)? validator,
    bool obscure,
    int maxLength,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        maxLength: maxLength,
        validator: validator,
        controller: textEditingController,
        obscureText: obscure,
        style: AppTextStyle.rubicRegular20,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 10,
          ),
          counterText: '',
          hintStyle: AppTextStyle.rubicRegularHint20,
          hintText: hintText,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.white,
              width: 3,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.red,
              width: 1,
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.red,
              width: 1,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.white54,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginForm({
    required String label,
    required BuildContext context,
    required VoidCallback func,
  }) {
    return Container(
      height: MediaQuery.of(context).size.height - 480,
      width: MediaQuery.of(context).size.width - 1000,
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _loginFormKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                bottom: AppDimensions.padding20,
              ),
              child: _inputBar(
                'general.email'.tr(),
                _emailController,
                _emailValidator,
                false,
                40,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: AppDimensions.padding20,
              ),
              child: _inputBar(
                'general.password'.tr(),
                _passwordController,
                _passwordValidator,
                true,
                30,
              ),
            ),
            const SizedBox(height: AppDimensions.padding20),
            Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(AppDimensions.borderRadius4),
                color: AppColors.white,
              ),
              height: 50,
              width: MediaQuery.of(context).size.width - 1040,
              child: TextButton(
                onPressed: () {
                  if (_loginFormKey.currentState!.validate()) {
                    context.read<AuthBloc>().add(
                          SignInWithEmailAndPasswordEvent(
                            email: _emailController.text,
                            password: _passwordController.text,
                          ),
                        );
                  } else {
                    return null;
                  }
                },
                child: Text(
                  'general.login_uppercase'.tr(),
                  style: AppTextStyle.rubicRegularLoginButton20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _registerForm({
    required String label,
    required BuildContext context,
    required VoidCallback func,
  }) {
    return Container(
      height: MediaQuery.of(context).size.height - 320,
      width: MediaQuery.of(context).size.width - 1000,
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _registerFormKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                bottom: AppDimensions.padding20,
              ),
              child: _inputBar(
                'general.first_name'.tr(),
                _firstNameController,
                _nameValidator,
                false,
                30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: AppDimensions.padding20,
              ),
              child: _inputBar(
                'general.last_name'.tr(),
                _lastNameController,
                _nameValidator,
                false,
                30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: AppDimensions.padding20,
              ),
              child: _inputBar(
                'general.email'.tr(),
                _emailController,
                _emailValidator,
                false,
                40,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: AppDimensions.padding20,
              ),
              child: _inputBar(
                'general.password'.tr(),
                _passwordController,
                _passwordValidator,
                true,
                30,
              ),
            ),
            const SizedBox(height: AppDimensions.padding20),
            Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(AppDimensions.borderRadius4),
                color: AppColors.white,
              ),
              height: 50,
              width: MediaQuery.of(context).size.width - 40,
              child: TextButton(
                onPressed: () {
                  if (_registerFormKey.currentState!.validate()) {
                    context.read<AuthBloc>().add(
                          RegisterWithEmailAndPasswordEvent(
                            email: _emailController.text,
                            password: _passwordController.text,
                            firstName: _firstNameController.text,
                            lastName: _lastNameController.text,
                          ),
                        );
                  } else {
                    return null;
                  }
                },
                child: Text(
                  'general.register_uppercase'.tr(),
                  style: AppTextStyle.rubicRegularLoginButton20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
