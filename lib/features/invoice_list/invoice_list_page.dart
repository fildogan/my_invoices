import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:moje_faktury/app/core/enums.dart';
import 'package:moje_faktury/domain/models/invoice_model.dart';
import 'package:moje_faktury/features/invoice_details/invoice_details_page.dart';
import 'package:moje_faktury/features/menu_drawer/menu_drawer.dart';

class InvoiceListPage extends StatefulWidget {
  const InvoiceListPage({super.key});

  @override
  State<InvoiceListPage> createState() => _InvoiceListPageState();
}

class _InvoiceListPageState extends State<InvoiceListPage> {
  SortedBy sortedBy = SortedBy.titleDescending;
  SelectedSort selectedSort = SelectedSort.title;
  SortDirection ascending = SortDirection.descending;

  @override
  Widget build(BuildContext context) {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoices'),
        actions: [
          IconButton(
              onPressed: _showSortDialog,
              icon: const Icon(
                Icons.sort,
              ))
        ],
      ),
      drawer: const MenuDrawer(),
      body: Stack(
        children: [
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
                return ListView.builder(
                  itemCount: invoices.length,
                  itemBuilder: (context, index) {
                    if (sortedBy == SortedBy.titleDescending) {
                      invoices.sort((invoice1, invoice2) =>
                          invoice1.title.compareTo(invoice2.title));
                    } else if (sortedBy == SortedBy.titleAscending) {
                      invoices.sort((invoice1, invoice2) =>
                          invoice2.title.compareTo(invoice1.title));
                    } else if (sortedBy == SortedBy.contrahentDescending) {
                      invoices.sort((invoice1, invoice2) =>
                          invoice1.contrahent.compareTo(invoice2.contrahent));
                    } else if (sortedBy == SortedBy.contrahentAscending) {
                      invoices.sort((invoice1, invoice2) =>
                          invoice2.contrahent.compareTo(invoice1.contrahent));
                    } else if (sortedBy == SortedBy.netDescending) {
                      invoices.sort((invoice1, invoice2) =>
                          invoice2.net.compareTo(invoice1.net));
                    } else if (sortedBy == SortedBy.netAscending) {
                      invoices.sort((invoice1, invoice2) =>
                          invoice1.net.compareTo(invoice2.net));
                    } else if (sortedBy == SortedBy.grossDescending) {
                      invoices.sort((invoice1, invoice2) =>
                          invoice1.gross.compareTo(invoice2.gross));
                    } else {
                      invoices.sort((invoice1, invoice2) =>
                          invoice2.gross.compareTo(invoice1.gross));
                    }
                    final invoice = invoices[index];
                    return InvoiceTile(invoiceModel: invoice);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showSortDialog() async {
    return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sort By'),
          content: SizedBox(
            height: 400,
            width: 300,
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return ListView(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RadioListTile(
                    toggleable: true,
                    value: SelectedSort.title,
                    groupValue: selectedSort,
                    title: const Text('Title'),
                    onChanged: (value) {
                      setState(() {
                        selectedSort = value!;
                      });
                    },
                  ),
                  RadioListTile(
                    toggleable: true,
                    value: SelectedSort.contrahent,
                    groupValue: selectedSort,
                    title: const Text('Contrahent'),
                    onChanged: (value) {
                      setState(() {
                        selectedSort = value!;
                      });
                    },
                  ),
                  RadioListTile(
                    toggleable: true,
                    value: SelectedSort.net,
                    groupValue: selectedSort,
                    title: const Text('Net Value'),
                    onChanged: (value) {
                      setState(() {
                        selectedSort = value!;
                      });
                    },
                  ),
                  RadioListTile(
                    toggleable: true,
                    value: SelectedSort.gross,
                    groupValue: selectedSort,
                    title: const Text('Gross Value'),
                    onChanged: (value) {
                      setState(() {
                        selectedSort = value!;
                      });
                    },
                  ),
                  const Divider(),
                  RadioListTile<SortDirection>(
                    toggleable: true,
                    value: SortDirection.ascending,
                    groupValue: ascending,
                    title: const Text('Ascending'),
                    onChanged: (SortDirection? value) {
                      setState(() {
                        ascending = value!;
                      });
                    },
                  ),
                  RadioListTile<SortDirection>(
                    toggleable: true,
                    value: SortDirection.descending,
                    groupValue: ascending,
                    title: const Text('Descending'),
                    onChanged: (SortDirection? value) {
                      setState(() {
                        ascending = value!;
                      });
                    },
                  ),
                ],
              );
            }),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Sort'),
              onPressed: () {
                setState(() {
                  if (ascending == SortDirection.descending) {
                    if (selectedSort == SelectedSort.title) {
                      sortedBy = SortedBy.titleDescending;
                    } else if (selectedSort == SelectedSort.contrahent) {
                      sortedBy = SortedBy.contrahentDescending;
                    } else if (selectedSort == SelectedSort.net) {
                      sortedBy = SortedBy.netDescending;
                    } else if (selectedSort == SelectedSort.gross) {
                      sortedBy = SortedBy.grossDescending;
                    }
                  } else {
                    if (selectedSort == SelectedSort.title) {
                      sortedBy = SortedBy.titleAscending;
                    } else if (selectedSort == SelectedSort.contrahent) {
                      sortedBy = SortedBy.contrahentAscending;
                    } else if (selectedSort == SelectedSort.net) {
                      sortedBy = SortedBy.netAscending;
                    } else if (selectedSort == SelectedSort.gross) {
                      sortedBy = SortedBy.grossAscending;
                    }
                  }
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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
