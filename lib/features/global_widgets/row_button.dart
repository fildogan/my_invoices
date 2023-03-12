import 'package:flutter/material.dart';

class RowButton extends StatelessWidget {
  const RowButton(
      {super.key, required this.text, required this.child, this.onTap});

  final String text;
  final Widget child;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(text), child],
        ),
      ),
    );
  }
}
