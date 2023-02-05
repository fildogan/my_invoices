import 'package:flutter/material.dart';

class BackgroundFaded extends StatelessWidget {
  const BackgroundFaded({
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
            opacity: const AlwaysStoppedAnimation(.3),
          ),
        ],
      ),
    );
  }
}
