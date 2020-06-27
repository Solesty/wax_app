import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wax_app/providers/settings_provider.dart';

class Settings extends StatelessWidget {
  const Settings({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 25.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Units"),
                DropdownButton<String>(
                    value: settingsProvider.units,
                    items: <String>["Imperial", "Metric"]
                        .map((String value) => DropdownMenuItem<String>(
                            child: Text(value), value: value))
                        .toList(),
                    onChanged: (String value) {
                      settingsProvider.setUnits(value);
                    }),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Wax Lines"),
                    Container(
                      child: Wrap(
                        spacing: 5.0,
                        runSpacing: 5.0,
                        children: <Widget>[
                          FilterChip(
                              label: Text(
                                "Swix Option",
                                style: TextStyle(
                                    color: Theme.of(context).accentColor),
                              ),
                              selected:
                                  (settingsProvider.waxLines.contains("Swix"))
                                      ? true
                                      : false,
                              onSelected: (bool value) {
                                if (value == true) {
                                  settingsProvider.addWaxLine("Swix");
                                } else {
                                  settingsProvider.removeWaxLine("Swix");
                                }
                              }),
                          FilterChip(
                              label: Text(
                                "Toko Option",
                                style: TextStyle(
                                    color: Theme.of(context).accentColor),
                              ),
                              selected: 
                                  (settingsProvider.waxLines.contains("Toko"))
                                      ? true
                                      : false,
                              onSelected: (bool value) {
                                if (value == true) {
                                  settingsProvider.addWaxLine("Toko");
                                } else {
                                  settingsProvider.removeWaxLine("Toko");
                                }
                              }),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
