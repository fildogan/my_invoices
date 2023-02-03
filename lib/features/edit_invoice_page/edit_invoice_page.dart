import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moje_faktury/domain/models/invoice_model.dart';

class EditInvoicePage extends StatefulWidget {
  const EditInvoicePage({
    super.key,
    required this.invoiceModel,
  });

  final InvoiceModel invoiceModel;

  @override
  State<EditInvoicePage> createState() => _EditInvoicePageState();
}

class _EditInvoicePageState extends State<EditInvoicePage> {
  late String title;
  late String contrahent;
  late double net;
  late int vat;
  late double gross;
  TextEditingController grossController = TextEditingController();

  @override
  void initState() {
    setState(() {
      title = widget.invoiceModel.title;
      contrahent = widget.invoiceModel.contrahent;
      net = widget.invoiceModel.net;
      vat = widget.invoiceModel.vat;
      gross = double.parse(widget.invoiceModel.gross);
      calculateGross();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit ${widget.invoiceModel.title}'),
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
                    .doc(widget.invoiceModel.id)
                    .update({
                  'title': title,
                  'contrahent': contrahent,
                  'net': net,
                  'vat': vat,
                  'gross': gross.toStringAsFixed(2),
                });
              },
              icon: const Icon(
                Icons.save,
              ))
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            TextFormField(
              initialValue: widget.invoiceModel.title,
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
              initialValue: widget.invoiceModel.contrahent,
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
              initialValue: widget.invoiceModel.net.toString(),
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
              initialValue: '${widget.invoiceModel.vat}%',
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
              decoration: const InputDecoration(
                labelText: 'Gross amount',
                hintText: 'hint',
                contentPadding: EdgeInsets.all(10),
              ),
            ),
            TextFormField(
              initialValue: 'InvoiceXYZ0020.pdf',
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
