import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_invoices/features/menu_drawer/menu_drawer.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('User Page')),
        drawer: const MenuDrawer(),
        body: SafeArea(
          child: ProfileScreen(
            providers: [
              EmailAuthProvider(),
            ],
            actions: [
              SignedOutAction(
                (context) =>
                    Navigator.popUntil(context, (route) => route.isFirst),
              ),
            ],
            avatarSize: 24,
          ),
        ),
      );
}
