import 'package:flutter/material.dart';
import 'package:my_invoices/features/add_invoice/add_invoice_page.dart';
import 'package:my_invoices/features/global_widgets/background_full.dart';
import 'package:my_invoices/features/invoice_list/invoice_list_page.dart';
import 'package:my_invoices/features/menu_drawer/menu_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: const MenuDrawer(),
      body: Stack(
        children: [
          const BackgroundFullColor(),
          SafeArea(
            child: Center(
              child: Column(
                children: [
                  const Spacer(
                    flex: 2,
                  ),
                  Image.asset(
                    'assets/images/my_invoices_logo.png',
                    height: 200,
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const AddInvoicePage()));
                            },
                            icon: const Icon(Icons.note_add),
                            label: const Text('Add an invoice')),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const InvoiceListPage()));
                            },
                            icon: const Icon(Icons.list),
                            label: const Text('List of Invoices')),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const Spacer(
                    flex: 4,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
