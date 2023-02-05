import 'package:flutter/material.dart';

class BackgroundFullColor extends StatelessWidget {
  const BackgroundFullColor({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset(
            'assets/images/background1.jpg',
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
