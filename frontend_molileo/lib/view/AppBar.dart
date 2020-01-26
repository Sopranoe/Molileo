import 'package:flutter/material.dart';
import 'package:frontend_molileo/screens/mole_history_screen.dart';
import 'package:frontend_molileo/screens/mole_overview_screen.dart';

import '../main.dart';

AppBar appBar(String title, String subtitle) {
  return new AppBar(
    iconTheme: IconThemeData(color: Colors.black),
    title: Column(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(color: Colors.black, fontSize: 25.0),
          textAlign: TextAlign.center,
        ),
        Text(
          subtitle,
          style: TextStyle(color: Colors.black38, fontSize: 12.0),
          textAlign: TextAlign.center,
        )
      ],
    ),
    automaticallyImplyLeading: true,
    centerTitle: true,
    backgroundColor: Colors.grey[100],
  );
}

AppBar appBarWithAction(
    String title, String subtitle, BuildContext context, dynamic navigateTo) {
  return new AppBar(
    iconTheme: IconThemeData(color: Colors.black),
    title: Column(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(color: Colors.black, fontSize: 25.0),
          textAlign: TextAlign.center,
        ),
        Text(
          subtitle,
          style: TextStyle(color: Colors.black38, fontSize: 12.0),
          textAlign: TextAlign.center,
        )
      ],
    ),
    automaticallyImplyLeading: true,
    leading: BackButton(
        color: Colors.black,
        onPressed: () => {
              if (navigateTo == 'home')
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyHomePage(title: 'Molileo')))
                }
              else if (navigateTo == 'overview')
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MoleOverviewScreen()))
                }
            }),
    centerTitle: true,
    backgroundColor: Colors.grey[100],
  );
}
