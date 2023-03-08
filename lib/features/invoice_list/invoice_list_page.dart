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
              onPressed: showSortDialog,
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

  Future<void> showSortDialog() async {
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
                  selectedSortRadioTile(
                      setState: setState,
                      value: SelectedSort.title,
                      title: 'Title'),
                  selectedSortRadioTile(
                      setState: setState,
                      value: SelectedSort.contrahent,
                      title: 'Contrahent'),
                  selectedSortRadioTile(
                      setState: setState,
                      value: SelectedSort.net,
                      title: 'Net Value'),
                  selectedSortRadioTile(
                      setState: setState,
                      value: SelectedSort.gross,
                      title: 'Gross Value'),
                  const Divider(),
                  sortDirectionRadioTile(
                    setState: setState,
                    value: SortDirection.ascending,
                    title: 'Ascending',
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

  RadioListTile<SortDirection> sortDirectionRadioTile({
    required StateSetter setState,
    required SortDirection value,
    required String title,
  }) {
    return RadioListTile<SortDirection>(
      toggleable: true,
      value: SortDirection.ascending,
      groupValue: ascending,
      title: const Text('Ascending'),
      onChanged: (SortDirection? value) {
        setState(() {
          ascending = value!;
        });
      },
    );
  }

  RadioListTile<SelectedSort> selectedSortRadioTile({
    required StateSetter setState,
    required SelectedSort value,
    required String title,
  }) {
    return RadioListTile(
      toggleable: true,
      value: value,
      groupValue: selectedSort,
      title: Text(title),
      onChanged: (value) {
        setState(() {
          selectedSort = value!;
        });
      },
    );
  }
}
