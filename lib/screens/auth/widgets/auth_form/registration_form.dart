import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:know_your_time/screens/auth/utils/validator.dart';
import 'package:know_your_time/screens/auth/widgets/input_bar.dart';

class RegistrationForm extends StatelessWidget {
  final String label;
  final BuildContext context;
  final void Function(
    String email,
    String password,
    String firstName,
    String lastName,
  ) onTap;

  RegistrationForm({
    required this.label,
    required this.context,
    required this.onTap,
  });

  final _registerFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _registerFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.padding20,
          vertical: AppDimensions.padding20,
        ),
        child: Column(
          children: <Widget>[
            InputBar(
              hintText: 'general.first_name'.tr(),
              textEditingController: _firstNameController,
              validator: Validator.nameValidator,
              obscure: false,
              maxLength: 30,
            ),
            const SizedBox(height: AppDimensions.padding20),
            InputBar(
              hintText: 'general.last_name'.tr(),
              textEditingController: _lastNameController,
              validator: Validator.nameValidator,
              obscure: false,
              maxLength: 30,
            ),
            const SizedBox(height: AppDimensions.padding20),
            InputBar(
              hintText: 'general.email'.tr(),
              textEditingController: _emailController,
              validator: Validator.emailValidator,
              obscure: false,
              maxLength: 40,
            ),
            const SizedBox(height: AppDimensions.padding20),
            InputBar(
              hintText: 'general.password'.tr(),
              textEditingController: _passwordController,
              validator: Validator.passwordValidator,
              obscure: true,
              maxLength: 30,
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
                    onTap(
                      _emailController.text,
                      _passwordController.text,
                      _firstNameController.text,
                      _lastNameController.text,
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
