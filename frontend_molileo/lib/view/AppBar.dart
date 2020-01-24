import 'package:flutter/material.dart';

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

// ListTile(
// title:
// subtitle:
// )
