import 'package:freezed_annotation/freezed_annotation.dart';

part 'invoice_model.freezed.dart';

// RUN IN TERMINAL: flutter pub run build_runner build --delete-conflicting-outputs

@freezed
class InvoiceModel with _$InvoiceModel {
  const factory InvoiceModel({
    required String id,
    required String title,
    required String contrahent,
    required double net,
    required int vat,
    required String gross,
    required String fileName,
  }) = _InvoiceModel;
  const InvoiceModel._();
}
