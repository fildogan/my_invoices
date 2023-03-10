import 'package:flutter/material.dart';
import 'package:moje_faktury/app/core/config.dart';
import 'package:moje_faktury/features/add_invoice/add_invoice_page.dart';
import 'package:moje_faktury/features/auth/user_profile.dart';
import 'package:moje_faktury/features/home_page/home_page.dart';
import 'package:moje_faktury/features/invoice_list/invoice_list_page.dart';
import 'package:moje_faktury/features/settings_page/settings_page.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  child: DrawerHeader(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                'assets/images/background1.jpg',
                              ))),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/my_invoices_logo.png',
                            height: 100,
                          )
                        ],
                      )),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.home,
                    size: 24,
                  ),
                  title: const Text(
                    'Home',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const HomePage()));
                  },
                ),
                const Divider(),
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
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
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
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const InvoiceListPage()));
                  },
                ),
                const Divider(),
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
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const UserProfile()));
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.settings,
                    size: 24,
                  ),
                  title: const Text(
                    'Settings',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SettingsPage()));
                  },
                ),
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Text(Config.versionMessage),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
