
import 'package:flutter/material.dart';

extension StringExtension on String {
  bool get isNotEmpty {
    return trim().isNotEmpty;
  }

  bool get isGreaterThanZero {
    try {
      final numValue = num.parse(this);
      return numValue > 0;
    } catch (_) {
      return false;
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
