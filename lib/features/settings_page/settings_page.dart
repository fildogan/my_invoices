import 'package:flutter/material.dart';
import 'package:moje_faktury/features/global_widgets/background_full.dart';
import 'package:moje_faktury/features/menu_drawer/menu_drawer.dart';
import 'package:package_info_plus/package_info_plus.dart';

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
              child: Column(
                children: [
                  const Spacer(
                    flex: 2,
                  ),
                  Image.asset(
                    'assets/images/my_invoices_logo.png',
                    opacity: const AlwaysStoppedAnimation(.3),
                    height: 200,
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  const Text(
                    'Designed & Developed by:',
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    'Filip Doganowski',
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    'for:',
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    'SSC MASTER',
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
