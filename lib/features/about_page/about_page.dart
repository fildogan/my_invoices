import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_invoices/app/url_links.dart';
import 'package:my_invoices/features/global_widgets/app_developer_info.dart';
import 'package:my_invoices/features/global_widgets/background_full.dart';
import 'package:my_invoices/features/global_widgets/row_button.dart';
import 'package:my_invoices/features/menu_drawer/menu_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({
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
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  RowButton(
                    text: 'Privacy policy',
                    child: const Icon(Icons.chevron_right),
                    onTap: () => launchUrlSite(url: flutterDogUrl),
                  ),
                  RowButton(
                    text: 'Contact',
                    child: const Icon(Icons.chevron_right),
                    onTap: () => launchEmail(),
                  ),
                  RowButton(
                    text: 'Developer site',
                    child: const Icon(Icons.chevron_right),
                    onTap: () => launchUrlSite(url: flutterDogUrl),
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

Future<void> launchUrlSite({required String url}) async {
  final Uri urlParsed = Uri.parse(url);

  if (await canLaunchUrl(urlParsed)) {
    await launchUrl(urlParsed);
  } else {
    throw 'Could not launch $url';
  }
}

Future<void> launchEmail() async {
  final String email = Uri.encodeComponent("filip.doganowski@gmail.com");
  // final String subject = Uri.encodeComponent("Feedback");
  // final String body = Uri.encodeComponent("Hi!\nHere is my feedback:\n");
  // final Uri mail = Uri.parse("mailto:$email?subject=$subject&body=$body");
  final Uri mail = Uri.parse("mailto:$email");

  try {
    final bool launched = await launchUrl(mail);
    if (launched) {
      // email app opened
    } else {
      // email app is not opened
      throw Exception('Could not launch email app');
    }
  } on PlatformException catch (e) {
    throw Exception('Error launching email: $e');
  }
}
