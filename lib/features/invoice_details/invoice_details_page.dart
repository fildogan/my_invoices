import 'package:flutter/material.dart';

class InvoiceDetailsPage extends StatefulWidget {
  const InvoiceDetailsPage({super.key});

  @override
  State<InvoiceDetailsPage> createState() => _InvoiceDetailsPageState();
}

class _InvoiceDetailsPageState extends State<InvoiceDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice XYZ0020'),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.edit_document,
              ))
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            TextFormField(
              initialValue: 'Invoice XYZ0020',
              enabled: false,
              decoration: const InputDecoration(
                labelText: 'Invoice no.',
                contentPadding: EdgeInsets.all(10),
              ),
            ),
            TextFormField(
              initialValue: 'Contrahent: Google LLC',
              enabled: false,
              decoration: const InputDecoration(
                labelText: 'Contrahent',
                contentPadding: EdgeInsets.all(10),
              ),
            ),
            TextFormField(
              initialValue: '1000 PLN',
              enabled: false,
              decoration: const InputDecoration(
                labelText: 'Net amount',
                contentPadding: EdgeInsets.all(10),
              ),
            ),
            TextFormField(
              initialValue: '23%',
              enabled: false,
              decoration: const InputDecoration(
                labelText: 'VAT rate',
                contentPadding: EdgeInsets.all(10),
              ),
            ),
            TextFormField(
              initialValue: '1230 PLN',
              enabled: false,
              decoration: const InputDecoration(
                labelText: 'Gross amount',
                contentPadding: EdgeInsets.all(10),
              ),
            ),
            TextFormField(
              initialValue: 'InvoiceXYZ0020.pdf',
              enabled: false,
              decoration: const InputDecoration(
                labelText: 'Attachment',
                contentPadding: EdgeInsets.all(10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
