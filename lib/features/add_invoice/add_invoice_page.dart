import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moje_faktury/features/menu_drawer/menu_drawer.dart';

class AddInvoicePage extends StatefulWidget {
  const AddInvoicePage({super.key});

  @override
  State<AddInvoicePage> createState() => _AddInvoicePageState();
}

class _AddInvoicePageState extends State<AddInvoicePage> {
  String title = '';
  String contrahent = '';
  double net = 0;
  int vat = 0;
  double gross = 0;
  TextEditingController grossController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add invoice'),
        actions: [
          IconButton(
              onPressed: () async {
                final userID = FirebaseAuth.instance.currentUser?.uid;
                if (userID == null) {
                  throw Exception('User is not logged in');
                }
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(userID)
                    .collection('invoices')
                    .add({
                  'title': title,
                  'contrahent': contrahent,
                  'net': net,
                  'vat': vat,
                });
              },
              icon: const Icon(
                Icons.save,
              ))
        ],
      ),
      drawer: const MenuDrawer(),
      body: SafeArea(
        child: ListView(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Invoice no.',
                contentPadding: EdgeInsets.all(10),
              ),
              onChanged: (newValue) {
                setState(() {
                  title = newValue;
                });
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Contrahent',
                contentPadding: EdgeInsets.all(10),
              ),
              onChanged: (newValue) {
                setState(() {
                  contrahent = newValue;
                });
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Net amount',
                contentPadding: EdgeInsets.all(10),
              ),
              onChanged: (newValue) {
                setState(() async {
                  net = double.parse(newValue);
                  calculateGross();
                });
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'VAT rate',
                contentPadding: EdgeInsets.all(10),
              ),
              onChanged: (newValue) {
                setState(() async {
                  vat = int.parse(newValue);
                  calculateGross();
                });
              },
            ),
            TextFormField(
              enabled: false,
              controller: grossController,
              // initialValue: gross.toStringAsFixed(2),
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
      ),
    );
  }

  void calculateGross() {
    gross = net + (net * (vat / 100));
    grossController.text = gross.toStringAsFixed(2);
  }
}
