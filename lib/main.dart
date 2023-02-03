import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moje_faktury/app/app.dart';
import 'package:moje_faktury/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // configureDependencies();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
