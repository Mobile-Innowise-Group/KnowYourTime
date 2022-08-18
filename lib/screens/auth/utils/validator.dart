import 'package:core_ui/core_ui.dart';

class Validator {
  static String? Function(String?)? get emailValidator {
    return (text) {
      if (text == null || text.isEmpty) {
        return 'general.cant_be_empty'.tr();
      }
      if (text.length < 4) {
        return 'general.too_short'.tr();
      }
      return null;
    };
  }

  static String? Function(String?)? get passwordValidator {
    return (text) {
      if (text == null || text.isEmpty) {
        return 'general.cant_be_empty'.tr();
      } else if (text.length < 8) {
        return 'general.too_short'.tr();
      } else if (text.contains('@')) {
        return 'general.do_not_use_the_invalid_symbol'.tr();
      }
      return null;
    };
  }

  static String? Function(String?)? get nameValidator {
    return (text) {
      if (text == null || text.isEmpty) {
        return 'general.cant_be_empty'.tr();
      } else if (text.length < 3) {
        return 'general.too_short'.tr();
      } else if (text.contains('@')) {
        return 'general.do_not_use_the_invalid_symbol'.tr();
      }
      return null;
    };
  }
}
