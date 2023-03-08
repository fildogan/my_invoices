import 'package:flutter/material.dart';

class BackgroundFullColor extends StatelessWidget {
  const BackgroundFullColor({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                'assets/images/background1.jpg',
                width: double.infinity,
                opacity: const AlwaysStoppedAnimation(.8),
              ),
            ],
          ),
        ),
        Container(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.grey.withOpacity(0.2)
              : Colors.black.withOpacity(0.8),
        ),
      ],
    );
  }
}
