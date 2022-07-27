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
  bool showLogin = true;

  final AuthService _authService = AuthService();

  Widget _logo() {
    const double imageSize = 60.0;
    return Padding(
      padding: EdgeInsets.only(
          top: AppDimensions.padding100, bottom: AppDimensions.padding20),
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

  Widget _inputBar(Icon icon, String hintText,
      TextEditingController textEditingController, bool obscure) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.padding20),
      child: TextField(
        controller: textEditingController,
        obscureText: obscure,
        style: AppTextStyle.rubicRegular20,
        decoration: InputDecoration(
          hintStyle: AppTextStyle.rubicRegularHint20,
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.white, width: 3),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.white54, width: 1),
          ),
          prefixIcon: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: AppDimensions.padding6),
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
                top: AppDimensions.padding10, bottom: AppDimensions.padding20),
            child:
                _inputBar(Icon(Icons.email), 'EMAIL', _emailController, false),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: AppDimensions.padding20),
            child: _inputBar(
                Icon(Icons.lock), 'PASSWORD', _passwordController, true),
          ),
          SizedBox(height: AppDimensions.padding20),
          Container(
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(AppDimensions.borderRadius4),
                color: AppColors.white),
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
          msg: "Can't SignIn you! Please check your email/password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 7,
          backgroundColor: AppColors.red,
          textColor: AppColors.white,
          fontSize: 16.0);
    } else {
      _emailController.clear();
      _passwordController.clear();
    }
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
          msg: "Can't Register you! Please check your email/password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 7,
          backgroundColor: AppColors.red,
          textColor: AppColors.white,
          fontSize: 16.0);
    } else {
      _emailController.clear();
      _passwordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.darkBlue,
      body: Column(
        children: <Widget>[
          _logo(),
          (showLogin
              ? Column(
                  children: <Widget>[
                    _authForm('LOGIN', _loginUser),
                    Padding(
                      padding: EdgeInsets.all(AppDimensions.padding10),
                      child: GestureDetector(
                        child: Text(
                          'Not registered yet? Register!',
                          style: AppTextStyle.rubicRegular20,
                        ),
                        onTap: () {
                          setState(() {
                            showLogin = false;
                          });
                        },
                      ),
                    )
                  ],
                )
              : Column(
                  children: <Widget>[
                    _authForm('REGISTER', _registerUser),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: GestureDetector(
                        child: Text(
                          'Already registered? Login!',
                          style: AppTextStyle.rubicRegular20,
                        ),
                        onTap: () {
                          setState(() {
                            showLogin = true;
                          });
                        },
                      ),
                    )
                  ],
                )),
        ],
      ),
    );
  }
}
