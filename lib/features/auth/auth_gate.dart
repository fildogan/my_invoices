import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:moje_faktury/features/add_invoice/add_invoice_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) => StreamBuilder<auth.User?>(
        stream: auth.FirebaseAuth.instance.authStateChanges(),
        // If the user is already signed-in, use it as initial data
        builder: (context, snapshot) {
          // User is not signed in
          if (!snapshot.hasData) {
            return SignInScreen(
              providers: [
                EmailAuthProvider(),
              ],
            );
          }
          // Render your application if authenticated
          return const AddInvoicePage(
              // title: 'title',
              );
        },
      );
}
