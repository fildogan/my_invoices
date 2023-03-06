import 'package:flutter/material.dart';
import 'package:my_invoices/app/core/enums.dart';
import 'package:my_invoices/domain/models/invoice_model.dart';
import 'package:my_invoices/features/invoice_list/widgets/invoice_list_tile.dart';

class InvoiceListView extends StatelessWidget {
  const InvoiceListView({
    super.key,
    required this.invoices,
    required this.sortedBy,
  });

  final List<InvoiceModel> invoices;
  final SortedBy sortedBy;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: invoices.length,
      itemBuilder: (context, index) {
        if (sortedBy == SortedBy.titleDescending) {
          invoices.sort(
              (invoice1, invoice2) => invoice1.title.compareTo(invoice2.title));
        } else if (sortedBy == SortedBy.titleAscending) {
          invoices.sort(
              (invoice1, invoice2) => invoice2.title.compareTo(invoice1.title));
        } else if (sortedBy == SortedBy.contrahentDescending) {
          invoices.sort((invoice1, invoice2) =>
              invoice1.contrahent.compareTo(invoice2.contrahent));
        } else if (sortedBy == SortedBy.contrahentAscending) {
          invoices.sort((invoice1, invoice2) =>
              invoice2.contrahent.compareTo(invoice1.contrahent));
        } else if (sortedBy == SortedBy.netDescending) {
          invoices.sort(
              (invoice1, invoice2) => invoice2.net.compareTo(invoice1.net));
        } else if (sortedBy == SortedBy.netAscending) {
          invoices.sort(
              (invoice1, invoice2) => invoice1.net.compareTo(invoice2.net));
        } else if (sortedBy == SortedBy.grossDescending) {
          invoices.sort(
              (invoice1, invoice2) => invoice1.gross.compareTo(invoice2.gross));
        } else {
          invoices.sort(
              (invoice1, invoice2) => invoice2.gross.compareTo(invoice1.gross));
        }
        final invoice = invoices[index];
        return InvoiceTile(invoiceModel: invoice);
      },
    );
  }
}
