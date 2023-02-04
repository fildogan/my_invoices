import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moje_faktury/api/pdf_api.dart';
import 'package:moje_faktury/domain/models/invoice_model.dart';
import 'package:moje_faktury/features/edit_invoice_page/edit_invoice_page.dart';
import 'package:moje_faktury/features/pdf_viewer/pdf_viewer_page.dart';

class InvoiceDetailsPage extends StatefulWidget {
  const InvoiceDetailsPage({
    super.key,
    required this.invoiceModel,
  });

  final InvoiceModel invoiceModel;

  @override
  State<InvoiceDetailsPage> createState() => _InvoiceDetailsPageState();
}

class _InvoiceDetailsPageState extends State<InvoiceDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.invoiceModel.title),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditInvoicePage(
                              invoiceModel: widget.invoiceModel,
                            )));
              },
              icon: const Icon(
                Icons.edit_document,
              ))
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            TextFormField(
              initialValue: widget.invoiceModel.title,
              enabled: false,
              decoration: const InputDecoration(
                labelText: 'Invoice no.',
                contentPadding: EdgeInsets.all(10),
              ),
            ),
            TextFormField(
              initialValue: widget.invoiceModel.contrahent,
              enabled: false,
              decoration: const InputDecoration(
                labelText: 'Contrahent',
                contentPadding: EdgeInsets.all(10),
              ),
            ),
            TextFormField(
              initialValue: '${widget.invoiceModel.net} PLN',
              enabled: false,
              decoration: const InputDecoration(
                labelText: 'Net amount',
                contentPadding: EdgeInsets.all(10),
              ),
            ),
            TextFormField(
              initialValue: '${widget.invoiceModel.vat}%',
              enabled: false,
              decoration: const InputDecoration(
                labelText: 'VAT rate',
                contentPadding: EdgeInsets.all(10),
              ),
            ),
            TextFormField(
              initialValue: '${widget.invoiceModel.gross} PLN',
              enabled: false,
              decoration: const InputDecoration(
                labelText: 'Gross amount',
                contentPadding: EdgeInsets.all(10),
              ),
            ),
            TextFormField(
              initialValue: widget.invoiceModel.fileName,
              enabled: false,
              decoration: const InputDecoration(
                labelText: 'Attachment',
                contentPadding: EdgeInsets.all(10),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: ElevatedButton(
                onPressed: () async {
                  final userID = FirebaseAuth.instance.currentUser?.uid;

                  final url =
                      'invoices/$userID/${widget.invoiceModel.id}/${widget.invoiceModel.fileName}';
                  final file = await PDFApi.loadFirebase(url);
                  if (file != null) {
                    openPDF(context, file);
                  }
                },
                child: const Text('View pdf file'),
              ),
            )
          ],
        ),
      ),
    );
  }

  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)),
      );
}
