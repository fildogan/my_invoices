import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    super.key,
    required this.titleController,
    required this.title,
  });
  final String title;
  final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: titleController,
      enabled: false,
      decoration: InputDecoration(
        labelText: title,
        contentPadding: const EdgeInsets.all(10),
      ),
    );
  }
}
