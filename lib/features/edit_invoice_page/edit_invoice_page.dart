// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  late String fileName;
  bool isfileDeleted = false;

  Uint8List? fileBytes;
  TextEditingController grossController = TextEditingController();
  TextEditingController fileNameController = TextEditingController();

  @override
  void initState() {
    setState(() {
      title = widget.invoiceModel.title;
      contrahent = widget.invoiceModel.contrahent;
      net = widget.invoiceModel.net;
      vat = widget.invoiceModel.vat;
      gross = double.parse(widget.invoiceModel.gross);
      fileName = widget.invoiceModel.fileName;
      _calculateGross();
      _setFileName(fileName);
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
                  'file_name': fileName
                });
                if (isfileDeleted) {
                  await FirebaseStorage.instance
                      .ref(
                          'invoices/$userID/${widget.invoiceModel.id}/$fileName')
                      .putData(fileBytes!);
                }

                Navigator.pop(
                    context,
                    InvoiceModel(
                        id: widget.invoiceModel.id,
                        title: title,
                        contrahent: contrahent,
                        net: net,
                        vat: vat,
                        gross: gross.toStringAsFixed(2),
                        fileName: fileName));
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
                  _calculateGross();
                });
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'^\d*\.?\d{0,2}'),
                ),
              ],
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            // TextFormField(
            //   initialValue: '${widget.invoiceModel.vat}%',
            //   decoration: const InputDecoration(
            //     labelText: 'VAT rate',
            //     contentPadding: EdgeInsets.all(10),
            //   ),
            //   onChanged: (newValue) {
            //     setState(() async {
            //       vat = int.parse(newValue);
            //       _calculateGross();
            //     });
            //   },
            // ),
            DropdownButtonFormField<int>(
              value: widget.invoiceModel.vat,
              decoration: const InputDecoration(
                labelText: 'VAT rate',
                contentPadding: EdgeInsets.all(10),
              ),
              items: const [
                DropdownMenuItem(
                  value: 0,
                  child: Text(
                    '0%',
                  ),
                ),
                DropdownMenuItem(
                  value: 7,
                  child: Text(
                    '7%',
                  ),
                ),
                DropdownMenuItem(
                  value: 23,
                  child: Text(
                    '23%',
                  ),
                ),
              ],
              onChanged: (newValue) {
                setState(() async {
                  vat = newValue ?? vat;
                  _calculateGross();
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
            InkWell(
              onTap: () {
                if (isfileDeleted) {
                  _pickFiles();
                }
              },
              child: TextFormField(
                enabled: false,
                controller: fileNameController,
                decoration: const InputDecoration(
                  labelText: 'Attachment',
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  final userID = FirebaseAuth.instance.currentUser?.uid;
                  await FirebaseStorage.instance
                      .ref(
                          'invoices/$userID/${widget.invoiceModel.id}/$fileName')
                      .delete();
                  setState(() {
                    isfileDeleted = true;
                  });
                  _setFileName('');
                },
                child: const Text('delete file'))
          ],
        ),
      ),
    );
  }

  void _calculateGross() {
    gross = net + (net * (vat / 100));
    grossController.text = gross.toStringAsFixed(2);
  }

  void _setFileName(String name) {
    setState(() {
      fileName = name;
      fileNameController.text = name;
    });
  }

  void _setFileBytes(Uint8List bytes) {
    setState(() {
      fileBytes = bytes;
    });
  }

  void _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      withData: true,
    );

    if (result != null &&
        result.files.single.path != null &&
        result.files.first.bytes != null) {
      PlatformFile file = result.files.first;
      print(file.name);
      print(file.bytes);
      print(file.size);
      print(file.extension);
      print(file.path);

      _setFileName(file.name);

      _setFileBytes(file.bytes!);
    }
  }
}
