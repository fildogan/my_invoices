import 'package:flutter/material.dart';

class EditInvoicePage extends StatefulWidget {
  const EditInvoicePage({super.key});

  @override
  State<EditInvoicePage> createState() => _EditInvoicePageState();
}

class _EditInvoicePageState extends State<EditInvoicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit invoice XYZ0020'),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.save,
              ))
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            TextFormField(
              initialValue: 'Invoice XYZ0020',
              decoration: const InputDecoration(
                labelText: 'Invoice no.',
                contentPadding: EdgeInsets.all(10),
              ),
            ),
            TextFormField(
              initialValue: 'Contrahent: Google LLC',
              decoration: const InputDecoration(
                labelText: 'Contrahent',
                contentPadding: EdgeInsets.all(10),
              ),
            ),
            TextFormField(
              initialValue: '1000 PLN',
              decoration: const InputDecoration(
                labelText: 'Net amount',
                contentPadding: EdgeInsets.all(10),
              ),
            ),
            TextFormField(
              initialValue: '23%',
              decoration: const InputDecoration(
                labelText: 'VAT rate',
                contentPadding: EdgeInsets.all(10),
              ),
            ),
            TextFormField(
              initialValue: '1230 PLN',
              decoration: const InputDecoration(
                labelText: 'Gross amount',
                contentPadding: EdgeInsets.all(10),
              ),
            ),
            TextFormField(
              initialValue: 'InvoiceXYZ0020.pdf',
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
