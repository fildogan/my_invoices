import 'package:flutter/material.dart';
import 'package:moje_faktury/app/core/config.dart';
import 'package:moje_faktury/features/add_invoice/add_invoice_page.dart';
import 'package:moje_faktury/features/auth/user_profile.dart';
import 'package:moje_faktury/features/invoice_list/invoice_list_page.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                    child: DrawerHeader(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddInvoicePage()));
                    },
                  ),
                  ListTile(
                    title: const Text('List of invoices'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const InvoiceListPage()));
                    },
                  ),
                  ListTile(
                    title: const Text('Account'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserProfile()));
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(Config.versionMessage),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
