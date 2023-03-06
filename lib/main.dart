import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_invoices/app/app.dart';
import 'package:my_invoices/app/core/config.dart';
import 'package:my_invoices/firebase_options.dart';

void main() async {
  Config.appFlavor = Flavor.development;
  WidgetsFlutterBinding.ensureInitialized();
  // configureDependencies();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
