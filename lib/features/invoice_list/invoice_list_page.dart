import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
      body: Stack(children: [
        Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                'assets/images/background1.jpg',
                opacity: const AlwaysStoppedAnimation(.3),
              ),
            ],
          ),
        ),
        SafeArea(
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
                  return const Center(child: CircularProgressIndicator());
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
                      gross: doc['gross'].toString(),
                      fileName: doc['file_name'].toString(),
                      isFileAttached: doc['is_file_attached'],
                    );
                  },
                ).toList();
                if (invoices.isEmpty) {
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/my_invoices_logo.png',
                        width: 100,
                        height: 100,
                      ),
                      const Text('No invoices added yet...'),
                    ],
                  ));
                }
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
      ]),
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
                builder: (context) => InvoiceDetailsPage(
                      invoiceModel: invoiceModel,
                    )));
      },
      child: Dismissible(
        key: ValueKey(invoiceModel.id),
        onDismissed: (direction) async {
          final userID = FirebaseAuth.instance.currentUser?.uid;
          if (userID == null) {
            throw Exception('User is not logged in');
          }
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userID)
              .collection('invoices')
              .doc(invoiceModel.id)
              .delete();
          await FirebaseStorage.instance
              .ref(
                  'invoices/$userID/${invoiceModel.id}/${invoiceModel.fileName}')
              .delete();
        },
        direction: DismissDirection.endToStart,
        confirmDismiss: (direction) {
          return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Delete invoice ${invoiceModel.title}?'),
                content: const Text(
                  'This action is irreversible.',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Yes'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('No'),
                  )
                ],
              );
            },
          );
        },
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          color: Colors.red,
          child: const Icon(Icons.delete, color: Colors.white),
        ),
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
              Text('NET: ${invoiceModel.net.toStringAsFixed(2)} PLN'),
              Text('VAT: ${invoiceModel.vat}%'),
              Text('GROSS: ${invoiceModel.gross} PLN'),
            ],
          ),
        ),
      ),
    );
  }
}
