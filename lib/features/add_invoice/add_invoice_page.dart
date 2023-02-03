import 'package:flutter/material.dart';
import 'package:moje_faktury/features/menu_drawer/menu_drawer.dart';

class AddInvoicePage extends StatefulWidget {
  const AddInvoicePage({super.key});

  @override
  State<AddInvoicePage> createState() => _AddInvoicePageState();
}

class _AddInvoicePageState extends State<AddInvoicePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Add invoice'),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.save,
              ))
        ],
      ),
      drawer: const MenuDrawer(),
      body: ListView(
        children: [
          TextFormField(
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
