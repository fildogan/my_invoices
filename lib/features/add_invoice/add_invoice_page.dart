import 'package:flutter/material.dart';

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
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Text('menu')),
            ListTile(
              title: Text('Add invoice'),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text('List of invoices'),
              onTap: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    ));
  }
}
