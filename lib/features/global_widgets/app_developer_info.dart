import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppDeveloperInfo extends StatefulWidget {
  const AppDeveloperInfo({
    super.key,
  });

  @override
  State<AppDeveloperInfo> createState() => _AppDeveloperInfoState();
}

class _AppDeveloperInfoState extends State<AppDeveloperInfo> {
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
    return Center(
      child: Column(
        children: [
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
    );
  }
}
