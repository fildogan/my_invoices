import 'package:flutter/material.dart';

class InvoiceDetailsPage extends StatefulWidget {
  const InvoiceDetailsPage({super.key});

  @override
  State<InvoiceDetailsPage> createState() => _InvoiceDetailsPageState();
}

class _InvoiceDetailsPageState extends State<InvoiceDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Invoice XYZ0020'),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.save,
              ))
        ],
      ),
      body: ListView(
        children: [
          TextFormField(
            enabled: false,
            decoration: const InputDecoration(
              labelText: 'Invoice no.',
              contentPadding: EdgeInsets.all(10),
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Contrahent',
              contentPadding: EdgeInsets.all(10),
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Net amount',
              contentPadding: EdgeInsets.all(10),
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'VAT rate',
              contentPadding: EdgeInsets.all(10),
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Gross amount',
              contentPadding: EdgeInsets.all(10),
            ),
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Attachment',
              contentPadding: EdgeInsets.all(10),
            ),
          ),
        ],
      ),
    ));
  }
}
