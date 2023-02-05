import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
  late InvoiceModel currentInvoice;
  TextEditingController titleController = TextEditingController();
  TextEditingController contrahentController = TextEditingController();
  TextEditingController netController = TextEditingController();
  TextEditingController vatController = TextEditingController();
  TextEditingController grossController = TextEditingController();
  TextEditingController fileNameController = TextEditingController();

  @override
  void initState() {
    setState(() {
      currentInvoice = widget.invoiceModel;
    });
    updateFields(currentInvoice);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentInvoice.title),
        actions: [
          IconButton(
              onPressed: () {
                goToEditInvoicePage(currentInvoice);
              },
              icon: const Icon(
                Icons.edit_document,
              ))
        ],
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  'assets/images/background1.jpg',
                ),
              ],
            ),
          ),
          SafeArea(
            child: ListView(
              children: [
                TextFormField(
                  controller: titleController,
                  enabled: false,
                  decoration: const InputDecoration(
                    labelText: 'Invoice no.',
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
                TextFormField(
                  controller: contrahentController,
                  enabled: false,
                  decoration: const InputDecoration(
                    labelText: 'Contrahent',
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
                TextFormField(
                  controller: netController,
                  enabled: false,
                  decoration: const InputDecoration(
                    labelText: 'Net amount',
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
                TextFormField(
                  controller: vatController,
                  enabled: false,
                  decoration: const InputDecoration(
                    labelText: 'VAT rate',
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
                TextFormField(
                  controller: grossController,
                  enabled: false,
                  decoration: const InputDecoration(
                    labelText: 'Gross amount',
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
                TextFormField(
                  controller: fileNameController,
                  enabled: false,
                  decoration: const InputDecoration(
                    labelText: 'Attachment',
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: ElevatedButton(
                    onPressed: currentInvoice.isFileAttached
                        ? () async {
                            final userID =
                                FirebaseAuth.instance.currentUser?.uid;

                            final url =
                                'invoices/$userID/${currentInvoice.id}/${currentInvoice.fileName}';
                            final file = await PDFApi.loadFirebase(url);
                            if (file != null) {
                              openPDF(context, file);
                            }
                          }
                        : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.file_open),
                        SizedBox(
                          width: 5,
                        ),
                        Text('View pdf file'),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)),
      );

  void goToEditInvoicePage(InvoiceModel invoiceModel) async {
    final newInvoice = await Navigator.push(
      context,
      CupertinoPageRoute(
          fullscreenDialog: true,
          builder: (context) => EditInvoicePage(
                invoiceModel: currentInvoice,
              )),
    );
    updateInvoice(newInvoice);
  }

  void updateInvoice(InvoiceModel newInvoice) {
    setState(() {
      currentInvoice = newInvoice;
    });
    updateFields(newInvoice);
  }

  void updateFields(InvoiceModel newInvoice) {
    setState(() {
      titleController.text = newInvoice.title;
      contrahentController.text = newInvoice.contrahent;
      netController.text = newInvoice.net.toStringAsFixed(2);
      vatController.text = '${newInvoice.vat.toString()}%';
      grossController.text = newInvoice.gross;
      if (newInvoice.isFileAttached) {
        fileNameController.text = newInvoice.fileName;
      } else {
        fileNameController.text = 'No files attached';
      }
    });
  }
}
