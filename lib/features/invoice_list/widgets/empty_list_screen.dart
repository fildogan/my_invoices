import 'package:flutter/material.dart';

class ListEmpty extends StatelessWidget {
  const ListEmpty({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/my_invoices_logo.png',
          width: 100,
          height: 100,
        ),
        const SizedBox(
          height: 16,
        ),
        const Text('No invoices added yet...'),
        const SizedBox(
          height: 64,
        ),
      ],
    ));
  }
}
