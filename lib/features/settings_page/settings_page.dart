import 'package:flutter/material.dart';
import 'package:my_invoices/features/global_widgets/background_full.dart';
import 'package:my_invoices/features/menu_drawer/menu_drawer.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:my_invoices/app/theme.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    super.key,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

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
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const SettingsRow(
                    text: 'Theme: ',
                    child: ThemeToggleSwitch(),
                  ),
                  const Spacer(
                    flex: 6,
                  ),
                  const Text(
                    'Designed & Developed by:',
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    'Filip Doganowski',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'App version: ${_packageInfo.version} (${_packageInfo.buildNumber})',
                    textAlign: TextAlign.start,
                  ),
                  const Spacer(
                    flex: 4,
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

class SettingsRow extends StatelessWidget {
  const SettingsRow({super.key, required this.text, required this.child});

  final String text;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(text), const ThemeToggleSwitch()],
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
