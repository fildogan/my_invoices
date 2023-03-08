import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_invoices/domain/models/invoice_model.dart';

class InvoiceRepository {
  Stream<List<InvoiceModel>> getInvoiceStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('invoices')
        .orderBy('title')
        .snapshots()
        .map(
      (querySnapshot) {
        return querySnapshot.docs.map(
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
      },
    );
  }
}
