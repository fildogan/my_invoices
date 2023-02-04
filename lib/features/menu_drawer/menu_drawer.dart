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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                                onTap: () => Navigator.of(context).pop(),
                                child: const Icon(
                                  Icons.arrow_back,
                                  size: 30,
                                )),
                            const Expanded(
                              child: Text(
                                'Main menu',
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                            Image.asset(
                              'assets/images/my_invoices_logo.png',
                              height: 70,
                              width: 70,
                            )
                          ],
                        )),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.note_add,
                      size: 24,
                    ),
                    title: const Text(
                      'Add invoice',
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddInvoicePage()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.list,
                      size: 24,
                    ),
                    title: const Text(
                      'List of invoices',
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const InvoiceListPage()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.person,
                      size: 24,
                    ),
                    title: const Text(
                      'Account',
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserProfile()));
                    },
                  ),
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
