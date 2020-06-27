import 'package:flutter/material.dart';

import 'settings.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    );
  }
}
