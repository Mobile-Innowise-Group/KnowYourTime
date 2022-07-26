import 'package:flutter/material.dart';

import '../../core_ui.dart';

class AppProgressIndicator extends StatelessWidget {
  const AppProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(
        backgroundColor: AppColors.white,
      ),
    );
  }
}
