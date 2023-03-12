import 'package:flutter/material.dart';
import 'package:my_invoices/features/global_widgets/app_developer_info.dart';
import 'package:my_invoices/features/global_widgets/background_full.dart';
import 'package:my_invoices/features/global_widgets/row_button.dart';
import 'package:my_invoices/features/menu_drawer/menu_drawer.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:my_invoices/app/theme.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      drawer: const MenuDrawer(),
      body: Stack(
        children: [
          const BackgroundFullColor(),
          const AppDeveloperInfo(),
          SafeArea(
            child: Center(
              child: Column(children: [
                const Spacer(
                  flex: 1,
                ),
                Image.asset(
                  'assets/images/my_invoices_logo.png',
                  opacity: const AlwaysStoppedAnimation(.3),
                  height: 200,
                ),
                const Spacer(
                  flex: 3,
                ),
              ]),
            ),
          ),
          SafeArea(
            child: Center(
              child: Column(
                children: const [
                  SizedBox(
                    height: 10,
                  ),
                  RowButton(
                    text: 'Theme: ',
                    child: ThemeToggleSwitch(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
