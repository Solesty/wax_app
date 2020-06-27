import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wax_app/models/report.dart';
import 'package:wax_app/models/services/firestore_service.dart';
import 'package:wax_app/providers/settings_provider.dart';

import 'settings.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SettingsProvider settings = Provider.of<SettingsProvider>(context);

    var reports = Provider.of<List<Report>>(context)
            .where((report) => settings.waxLines.contains(report.line))
            .toList() ??
        [];
    FirestoreService _db = FirestoreService();

    return Scaffold(
      appBar: AppBar(
        title: Text("Wax App"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (c) => Settings()));
              })
        ],
      ),
      body: ListView.builder(
          itemCount: reports.length,
          itemBuilder: (c, index) {
            Report report = reports[index];

            return ListTile(
              leading: (settings.units == "Metric")
                  ? Text(
                      report.temp.toString() + "\u00B0",
                    )
                  : Text((((report.temp * (9 / 5)) + 32).round()).toString() +
                      "\u00B0"),
              title: Text(report.wax),
              subtitle: Text(report.line),
              trailing: Text(formatDate(
                  DateTime.parse(report.timeStamp), [h, ':', nn, ' ', am])),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _db.addReport();
        },
      ),
    );
  }
}
