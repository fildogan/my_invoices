import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) => ProfileScreen(
        appBar: AppBar(title: const Text('User Page')),
        providers: [
          EmailAuthProvider(),
        ],
        actions: [
          SignedOutAction(
            (context) => Navigator.of(context).pop(),
          ),
        ],
        avatarSize: 24,
      );
}
