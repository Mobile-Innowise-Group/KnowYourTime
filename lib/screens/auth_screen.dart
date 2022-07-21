import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';

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

  Widget _logo() {
    return Padding(
      padding: EdgeInsets.only(top: 100),
      child: Container(
        child: Align(
          child: Image.asset(
            'assets/images/flutter_logo.png',
            width: 50,
            height: 50,
          ),
        ),
      ),
    );
  }

  Widget _inputBar(Icon icon, String hintText,
      TextEditingController textEditingController, bool obscure) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: textEditingController,
        obscureText: obscure,
        style: TextStyle(fontSize: 20, color: AppColors.white),
        decoration: InputDecoration(
          hintStyle: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white30),
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 3),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white54, width: 1),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconTheme(
              child: icon,
              data: IconThemeData(color: Colors.white),
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
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            child:
                _inputBar(Icon(Icons.email), 'EMAIL', _emailController, false),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: _inputBar(
                Icon(Icons.lock), 'PASSWORD', _passwordController, true),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            color: AppColors.white,
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
        style: TextStyle(
            color: AppColors.backgroundAuth,
            fontWeight: FontWeight.bold,
            fontSize: 20),
      ),
    );
  }

  void _loginUser() {
    _email = _emailController.text;
    _password = _passwordController.text;

    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundAuth,
      body: Column(
        children: <Widget>[
          _logo(),
          (showLogin
              ? Column(
                  children: <Widget>[
                    _authForm('LOGIN', _loginUser),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: GestureDetector(
                        child: Text(
                          'Not registered yet? Register!',
                          style: TextStyle(fontSize: 20, color: Colors.white),
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
                    _authForm('REGISTER', _loginUser),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: GestureDetector(
                        child: Text(
                          'Already registered? Login!',
                          style: TextStyle(fontSize: 20, color: Colors.white),
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
