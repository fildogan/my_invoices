import 'package:flutter/material.dart';
import 'package:my_invoices/app/core/enums.dart';
import 'package:my_invoices/domain/models/invoice_model.dart';
import 'package:my_invoices/domain/repositories/invoice_repository.dart';
import 'package:my_invoices/features/global_widgets/background_faded.dart';
import 'package:my_invoices/features/global_widgets/loading_screen.dart';
import 'package:my_invoices/features/invoice_list/widgets/empty_list_screen.dart';
import 'package:my_invoices/features/invoice_list/widgets/invoice_list_view.dart';
import 'package:my_invoices/features/menu_drawer/menu_drawer.dart';

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
          const BackgroundFaded(),
          SafeArea(
            child: StreamBuilder<List<InvoiceModel>>(
              stream: InvoiceRepository().getInvoiceStream(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingScreen(
                      'Please wait, loading invoices...');
                }
                final invoices = snapshot.data!;
                if (invoices.isEmpty) {
                  return const ListEmpty();
                }
                return InvoiceListView(invoices: invoices, sortedBy: sortedBy);
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
