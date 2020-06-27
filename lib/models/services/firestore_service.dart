import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wax_app/models/report.dart';

class FirestoreService {
  Firestore _db = Firestore.instance;
  var random = Random();

  Stream<List<Report>> getReports() {
    // gets a query snapshot and change it to report

    return _db
        .collection("reports")
        .orderBy("timeStamp", descending: true)
        .snapshots()
        .map((snapshot) => snapshot.documents
            .map((document) => Report.toJSON(document.data))
            .toList());
  }

  Future<void> addReport() {
    var temp = next(-15, 5);
    var line = (temp < -10) ? "Swix" : "Toko";
    var wax = (temp.isEven) ? 'Red' : 'Green';
    var dataMap = Map<String, dynamic>();
    dataMap['line'] = line;
    dataMap['temp'] = temp;
    dataMap['wax'] = wax;
    dataMap['timeStamp'] = DateTime.now().toIso8601String();

    return _db.collection("reports").add(dataMap);
  }

  int next(int min, int max) => min + random.nextInt(max);
}
