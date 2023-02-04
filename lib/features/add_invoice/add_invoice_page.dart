// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moje_faktury/features/menu_drawer/menu_drawer.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddInvoicePage extends StatefulWidget {
  const AddInvoicePage({super.key});

  @override
  State<AddInvoicePage> createState() => _AddInvoicePageState();
}

class _AddInvoicePageState extends State<AddInvoicePage> {
  String title = '';
  String contrahent = '';
  double net = 0;
  int? vat;
  double gross = 0;
  Uint8List? fileBytes;
  String fileName = '';
  String invoiceId = '';
  TextEditingController grossController = TextEditingController();
  TextEditingController fileNameController = TextEditingController();

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
                  'gross': gross.toStringAsFixed(2),
                  'file_name': fileName
                }).then((value) {
                  setState(() {
                    invoiceId = value.id;
                  });
                });
                await FirebaseStorage.instance
                    .ref('invoices/$userID/$invoiceId/$fileName')
                    .putData(fileBytes!);
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
                setState(() {
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
            //   decoration: const InputDecoration(
            //     labelText: 'VAT rate',
            //     contentPadding: EdgeInsets.all(10),
            //   ),
            //   onChanged: (newValue) {
            //     setState(() {
            //       vat = int.parse(newValue);
            //       _calculateGross();
            //     });
            //   },
            // ),
            DropdownButtonFormField<int>(
              value: vat,
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
              // initialValue: gross.toStringAsFixed(2),
              decoration: const InputDecoration(
                labelText: 'Gross amount',
                contentPadding: EdgeInsets.all(10),
              ),
            ),
            InkWell(
              onTap: () {
                _pickFiles();
              },
              child: TextFormField(
                enabled: false,
                controller: fileNameController,
                onTap: () {
                  _pickFiles();
                },
                decoration: const InputDecoration(
                  labelText: 'Attachment',
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _setFileName(String name) {
    fileNameController.text = name;
    setState(() {
      fileName = name;
    });
  }

  void _setFileBytes(Uint8List bytes) {
    setState(() {
      fileBytes = bytes;
    });
  }

  void _calculateGross() {
    gross = net + (net * ((vat ?? 0) / 100));
    grossController.text = gross.toStringAsFixed(2);
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
