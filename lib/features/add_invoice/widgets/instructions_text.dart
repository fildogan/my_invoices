import 'package:flutter/material.dart';

class InstructionsText extends StatelessWidget {
  const InstructionsText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            children: [
              TextSpan(
                  text: 'Fill in all the fields and press the save ',
                  style: TextStyle(color: Colors.black54)),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.0),
                  child: Icon(
                    Icons.save,
                    color: Colors.black54,
                  ),
                ),
              ),
              TextSpan(
                  text: ' button to add invoice',
                  style: TextStyle(color: Colors.black54)),
            ],
          ),
        ),
      ),
    );
  }
}
