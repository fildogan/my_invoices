import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moje_faktury/domain/models/invoice_model.dart';
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
              final invoices = snapshot.data!.docs.map(
                (doc) {
                  return InvoiceModel(
                    id: doc.id,
                    title: doc['title'].toString(),
                    contrahent: doc['contrahent'].toString(),
                    net: doc.data().toString().contains('net')
                        ? double.parse(doc['net'].toString())
                        : 0.00,
                    vat: doc.data().toString().contains('vat')
                        ? int.parse(doc['vat'].toString())
                        : 0,
                  );
                },
              ).toList();

              return ListView(
                children: [
                  for (final invoice in invoices) ...[
                    InvoiceTile(
                      invoiceModel: invoice,
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
  const InvoiceTile({
    super.key,
    required this.invoiceModel,
  });

  final InvoiceModel invoiceModel;

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
        title: Text(invoiceModel.title),
        subtitle: Text(invoiceModel.contrahent),
        leading: const Icon(
          Icons.description,
          size: 40,
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('NET: ${invoiceModel.net} PLN'),
            Text('VAT: ${invoiceModel.vat}%'),
            const Text('GROSS: 1230 PLN'),
          ],
        ),
      ),
    );
  }
}
