import 'package:flutter/material.dart';
import 'package:moje_faktury/features/invoice_details/invoice_details_page.dart';
import 'package:moje_faktury/features/menu_drawer/menu_drawer.dart';

class InvoiceListPage extends StatelessWidget {
  const InvoiceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Invoices'),
        ),
        drawer: const MenuDrawer(),
        body: ListView(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const InvoiceDetailsPage()));
              },
              child: ListTile(
                title: const Text('Invoice XYZ10020'),
                subtitle: const Text('Contrahent: Google LLC'),
                leading: const Icon(
                  Icons.description,
                  size: 40,
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('NET: 1000 PLN'),
                    Text('VAT: 23%'),
                    Text('GROSS: 1230 PLN'),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
