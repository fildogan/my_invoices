import 'package:flutter/material.dart';

class InstructionsText extends StatelessWidget {
  const InstructionsText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Color textColor = Theme.of(context).brightness == Brightness.light
        ? Colors.black54
        : Colors.grey;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                  text: 'Fill in all the fields and press the save ',
                  style: TextStyle(color: textColor)),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Icon(
                    Icons.save,
                    color: textColor,
                  ),
                ),
              ),
              TextSpan(
                  text: ' button to add invoice',
                  style: TextStyle(color: textColor)),
            ],
          ),
        ),
      ),
    );
  }
}
