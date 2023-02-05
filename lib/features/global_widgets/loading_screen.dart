import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen(
    this.text, {
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(height: 16),
        Text(text),
        const SizedBox(
          height: 64,
        ),
      ],
    ));
  }
}
