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
            SizedBox(
              height: 80,
              child: DrawerHeader(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: const Icon(Icons.arrow_back)),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text('menu'),
                    ],
                  )),
            ),
            ListTile(
              title: const Text('Add invoice'),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('List of invoices'),
              onTap: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
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
