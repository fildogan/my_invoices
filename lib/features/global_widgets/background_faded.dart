import 'package:flutter/material.dart';

class BackgroundFaded extends StatelessWidget {
  const BackgroundFaded({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Theme.of(context).brightness == Brightness.light
                  ? Image.asset(
                      'assets/images/background1.jpg',
                      width: double.infinity,
                      opacity: const AlwaysStoppedAnimation(.2),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
        if (Theme.of(context).brightness == Brightness.light)
          Container(
            color: Colors.grey.withOpacity(0.2),
          ),
      ],
    );
  }
}
