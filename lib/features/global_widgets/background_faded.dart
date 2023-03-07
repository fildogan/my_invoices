import 'package:flutter/material.dart';
import 'package:my_invoices/app/core/config.dart';

class BackgroundFaded extends StatelessWidget {
  const BackgroundFaded({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: currentTheme.currentTheme == ThemeMode.light
          ? Colors.white
          : Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          currentTheme.currentTheme == ThemeMode.light
              ? Image.asset(
                  'assets/images/background1.jpg',
                  width: double.infinity,
                  opacity: const AlwaysStoppedAnimation(.2),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
