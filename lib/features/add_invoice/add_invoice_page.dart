// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moje_faktury/features/menu_drawer/menu_drawer.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:moje_faktury/utils/form_extensions.dart';

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

  TextEditingController titleController = TextEditingController();
  TextEditingController contrahentController = TextEditingController();
  TextEditingController netController = TextEditingController();
  TextEditingController grossController = TextEditingController();
  TextEditingController fileNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add invoice'),
        actions: [
          IconButton(
              onPressed: _addInvoice,
              icon: const Icon(
                Icons.save,
              ))
        ],
      ),
      drawer: const MenuDrawer(),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Invoice no.',
                  contentPadding: EdgeInsets.all(10),
                ),
                onChanged: (newValue) {
                  setState(() {
                    title = newValue;
                  });
                },
                validator: (val) {
                  if (val == null) {
                    return 'Must not be empty';
                  }
                  if (!val.isNotEmpty) {
                    return 'Must not be empty';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: contrahentController,
                decoration: const InputDecoration(
                  labelText: 'Contrahent',
                  contentPadding: EdgeInsets.all(10),
                ),
                onChanged: (newValue) {
                  setState(() {
                    contrahent = newValue;
                  });
                },
                validator: (val) {
                  if (val == null) {
                    return 'Must not be empty';
                  }
                  if (!val.isNotEmpty) {
                    return 'Must not be empty';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: netController,
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
                validator: (val) {
                  if (val == null) {
                    return 'Must not be empty';
                  }
                  if (!val.isNotEmpty) {
                    return 'Must not be empty';
                  }
                  if (!val.isGreaterThanZero) {
                    return 'Must be greater than 0';
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d*\.?\d{0,2}'),
                  ),
                ],
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              DropdownButtonFormField<int>(
                value: vat,
                decoration: const InputDecoration(
                  labelText: 'VAT rate',
                  contentPadding: EdgeInsets.all(10),
                ),
                validator: (val) {
                  if (vat == null) {
                    return 'Choose from list';
                  }
                  if (val == null) {
                    return 'Must not be empty';
                  }
                  if (!val.toString().isNotEmpty) {
                    return 'Must not be empty';
                  }
                  return null;
                },
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
                  setState(() {
                    vat = newValue ?? vat;
                    _calculateGross();
                  });
                },
              ),
              TextFormField(
                enableInteractiveSelection: false,
                focusNode: AlwaysDisabledFocusNode(),
                controller: grossController,
                decoration: const InputDecoration(
                  labelText: 'Gross amount',
                  contentPadding: EdgeInsets.all(10),
                ),
                validator: (val) {
                  if (val == null) {
                    return 'Net value must not be empty';
                  }
                  if (!val.isNotEmpty) {
                    return 'Net value must not be empty';
                  }
                  if (!val.isGreaterThanZero) {
                    return 'Net value must be greater than 0';
                  }
                  return null;
                },
              ),
              TextFormField(
                enableInteractiveSelection: false,
                focusNode: AlwaysDisabledFocusNode(),
                controller: fileNameController,
                onTap: () {
                  _pickFiles();
                },
                decoration: const InputDecoration(
                  labelText: 'Attachment',
                  contentPadding: EdgeInsets.all(10),
                ),
                validator: (val) {
                  if (val == null) {
                    return 'Pick a fle';
                  }
                  if (!val.isNotEmpty) {
                    return 'Pick a fle';
                  }
                  if (fileBytes == null) {
                    return 'Pick a fle';
                  }
                  return null;
                },
              ),
            ],
          ),
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

  void _clearValues() {
    setState(() {
      title = '';
      contrahent = '';
      net = 0;
      vat = null;
      gross = 0;
      fileBytes;
      fileName = '';
      invoiceId = '';
      fileBytes = null;
      _calculateGross();
      titleController.text = '';
      contrahentController.text = '';
      netController.text = '';
      grossController.text = '';
      fileNameController.text = '';
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

  Future<void> _addInvoice() async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    if (_formKey.currentState!.validate()) {
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
        'file_name': fileName,
        'is_file_attached': true
      }).then((value) {
        setState(() {
          invoiceId = value.id;
        });
      });
      await FirebaseStorage.instance
          .ref('invoices/$userID/$invoiceId/$fileName')
          .putData(fileBytes!);
      _clearValues();
    }
  }
}
