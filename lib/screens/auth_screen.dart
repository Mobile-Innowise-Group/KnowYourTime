import 'package:core_ui/core_ui.dart';
import 'package:data/src/services/firebase_auth_service.dart';
import 'package:domain/src/entities/user/user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({Key? key}) : super(key: key);

  @override
  _AuthorizationPageState createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late final String _email;
  late final String _password;
  bool isUserRegistered = true;

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    const double googleImageSize = 40.0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.darkBlue,
      body: Column(
        children: <Widget>[
          _logo,
          isUserRegistered
              ? Column(
                  children: <Widget>[
                    _authForm('general.login_uppercase'.tr(), _loginUser),
                    Padding(
                      padding: EdgeInsets.all(AppDimensions.padding10),
                      child: GestureDetector(
                        child: Text(
                          'general.not_registered'.tr(),
                          style: AppTextStyle.rubicRegular20,
                        ),
                        onTap: () => setState(() => isUserRegistered = false),
                      ),
                    )
                  ],
                )
              : Column(
                  children: <Widget>[
                    _authForm('general.register_uppercase'.tr(), _registerUser),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: GestureDetector(
                        child: Text(
                          'general.already_registered'.tr(),
                          style: AppTextStyle.rubicRegular20,
                        ),
                        onTap: () {
                          setState(() {
                            isUserRegistered = true;
                          });
                        },
                      ),
                    )
                  ],
                ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.padding20,
              vertical: AppDimensions.padding10,
            ),
            child: Divider(color: AppColors.textHintColor),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimensions.borderRadius20),
              color: AppColors.white,
            ),
            child: TextButton.icon(
              label: Text(
                'general.continue_with_google'.tr(),
                style: AppTextStyle.rubicRegularLoginButton20,
              ),
              onPressed: () {
                _loginWithGoogle;
              },
              icon: Image.asset(
                'assets/images/google_icon.png',
                height: googleImageSize,
                width: googleImageSize,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget get _logo {
    const double imageSize = 60.0;
    return Padding(
      padding: EdgeInsets.only(
        top: AppDimensions.padding100,
        bottom: AppDimensions.padding20,
      ),
      child: Container(
        child: Align(
          child: Image.asset(
            'assets/images/flutter_logo.png',
            width: imageSize,
            height: imageSize,
          ),
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
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.padding20),
      child: TextField(
        controller: textEditingController,
        obscureText: obscure,
        style: AppTextStyle.rubicRegular20,
        decoration: InputDecoration(
          hintStyle: AppTextStyle.rubicRegularHint20,
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.white,
              width: 3,
            ),
          ),
          enabledBorder: OutlineInputBorder(
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
              data: IconThemeData(color: AppColors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _authForm(String label, void func()) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: AppDimensions.padding10,
              bottom: AppDimensions.padding20,
            ),
            child: _inputBar(
              Icon(Icons.email),
              'general.email_uppercase'.tr(),
              _emailController,
              false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: AppDimensions.padding20),
            child: _inputBar(
              Icon(Icons.lock),
              'general.password_uppercase'.tr(),
              _passwordController,
              true,
            ),
          ),
          SizedBox(height: AppDimensions.padding20),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimensions.borderRadius4),
              color: AppColors.white,
            ),
            height: 50,
            width: MediaQuery.of(context).size.width - 40,
            child: _loginButton(label, func),
          ),
        ],
      ),
    );
  }

  Widget _loginButton(String textLabel, void func()) {
    return TextButton(
      onPressed: () {
        func();
      },
      child: Text(
        textLabel,
        style: AppTextStyle.rubicRegularLoginButton20,
      ),
    );
  }

  Future<void> _loginUser() async {
    _email = _emailController.text;
    _password = _passwordController.text;

    if (_email.isEmpty || _password.isEmpty) {
      return;
    }
    final UserInno? user = await _authService.signInWithEmailAndPassword(
        _email.trim(), _password.trim());
    if (user == null) {
      Fluttertoast.showToast(
        msg: 'general.cant_sign_in_toast'.tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 7,
        backgroundColor: AppColors.red,
        textColor: AppColors.white,
        fontSize: 16.0,
      );
    } else {
      _emailController.clear();
      _passwordController.clear();
    }
  }

  Future<void> get _loginWithGoogle async {
    await _authService.signInWithGoogle();
  }

  Future<void> _registerUser() async {
    _email = _emailController.text;
    _password = _passwordController.text;

    if (_email.isEmpty || _password.isEmpty) {
      return;
    }
    final UserInno? user = await _authService.registerWithEmailAndPassword(
        _email.trim(), _password.trim());
    if (user == null) {
      Fluttertoast.showToast(
        msg: 'general.cant_register_toast'.tr(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 7,
        backgroundColor: AppColors.red,
        textColor: AppColors.white,
        fontSize: 16.0,
      );
    } else {
      _emailController.clear();
      _passwordController.clear();
    }
  }
}
