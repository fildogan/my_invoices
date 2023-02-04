import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class PDFApi {
  static Future<File?> loadFirebase(String url) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(url);
      final bytes = await ref.getData();

      final filename = basename(url);
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$filename');
      await file.writeAsBytes(bytes!, flush: true);

      return file;
    } catch (e) {
      return null;
    }
  }
}
