import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_invoices/api/pdf_api.dart';
import 'package:my_invoices/domain/models/invoice_model.dart';
import 'package:my_invoices/features/edit_invoice_page/edit_invoice_page.dart';
import 'package:my_invoices/features/global_widgets/background_full.dart';
import 'package:my_invoices/features/global_widgets/loading_screen.dart';
import 'package:my_invoices/features/invoice_details/widgets/my_text_form_field.dart';
import 'package:my_invoices/features/pdf_viewer/pdf_viewer_page.dart';

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
  bool isLoading = false;

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
              onPressed: () => goToEditInvoicePage(currentInvoice),
              icon: const Icon(Icons.edit_document))
        ],
      ),
      body: Stack(
        children: [
          const BackgroundFullColor(),
          SafeArea(
            child: isLoading
                ? const LoadingScreen('Loading file, please wait...')
                : ListView(
                    children: [
                      MyTextFormField(
                          title: 'Invoice no.',
                          titleController: titleController),
                      MyTextFormField(
                          title: 'Contrahent',
                          titleController: contrahentController),
                      MyTextFormField(
                          title: 'Net amount', titleController: netController),
                      MyTextFormField(
                          title: 'VAT rate', titleController: vatController),
                      MyTextFormField(
                          title: 'Gross amount',
                          titleController: grossController),
                      MyTextFormField(
                          title: 'Attachment',
                          titleController: fileNameController),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: ElevatedButton(
                          onPressed: currentInvoice.isFileAttached || !isLoading
                              ? () async {
                                  setState(() {
                                    isLoading = true;
                                  });

                                  final userID =
                                      FirebaseAuth.instance.currentUser?.uid;
                                  final url =
                                      'invoices/$userID/${currentInvoice.id}/${currentInvoice.fileName}';
                                  final file = await PDFApi.loadFirebase(url);
                                  if (file != null) {
                                    if (mounted) {
                                      openPDF(context, file);
                                    }

                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                }
                              : null,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.file_open),
                              SizedBox(width: 5),
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
