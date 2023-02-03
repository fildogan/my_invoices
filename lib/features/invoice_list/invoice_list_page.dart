import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moje_faktury/features/invoice_details/invoice_details_page.dart';
import 'package:moje_faktury/features/menu_drawer/menu_drawer.dart';

class InvoiceListPage extends StatelessWidget {
  const InvoiceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoices'),
      ),
      drawer: const MenuDrawer(),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(userID)
                .collection('invoices')
                .orderBy('title')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              final invoices = snapshot.data!.docs;
              return ListView(
                children: [
                  for (final invoice in invoices) ...[
                    InvoiceTile(
                      title: invoice['title'].toString(),
                    )
                  ]
                ],
              );
            }),
      ),
    );
  }
}

class InvoiceTile extends StatelessWidget {
  const InvoiceTile({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const InvoiceDetailsPage()));
      },
      child: ListTile(
        title: Text(title),
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
    );
  }
}
