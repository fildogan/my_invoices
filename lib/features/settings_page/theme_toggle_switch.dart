import 'package:flutter/material.dart';
import 'package:my_invoices/app/theme.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ThemeToggleSwitch extends StatelessWidget {
  const ThemeToggleSwitch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ToggleSwitch(
      initialLabelIndex: MyTheme().index,
      cornerRadius: 4,
      totalSwitches: 3,
      labels: const ['Light', 'Dark', 'System'],
      onToggle: (index) {
        MyTheme().switchTheme(index!);
      },
    );
  }
}
