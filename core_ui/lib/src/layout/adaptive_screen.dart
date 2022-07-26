import 'package:flutter/material.dart';

class AdaptiveScreen extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;

  static const double _mobileMaxWidth = 1440.0;

  const AdaptiveScreen({
    required this.mobile,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        return constraints.maxWidth >= _mobileMaxWidth ? desktop : mobile;
      },
    );
  }
}
