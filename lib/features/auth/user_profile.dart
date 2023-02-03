import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:moje_faktury/features/menu_drawer/menu_drawer.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          appBar: AppBar(title: const Text('User Page')),
          drawer: const MenuDrawer(),
          body: ProfileScreen(
            providers: [
              EmailAuthProvider(),
            ],
            actions: [
              SignedOutAction(
                (context) => Navigator.of(context).pop(),
              ),
            ],
            avatarSize: 24,
          ),
        ),
      );
}
