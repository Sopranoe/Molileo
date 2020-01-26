import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:frontend_molileo/view/AppBar.dart';
import '../helper/textHelper.dart';

class InformationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: appBar('Molileo', 'Information'),
        body: new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: new Text('What our App is helping you with',
                    style: new TextStyle(
                        fontSize: 25.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Text(
                  appDescription,
                  style: new TextStyle(fontSize: 20.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: new Text('The causes of skin cancer',
                    style: new TextStyle(
                        fontSize: 25.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Text(
                  causes,
                  style: new TextStyle(fontSize: 20.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: new Text('Important information and disclaimer',
                    style: new TextStyle(
                        fontSize: 25.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Text(
                  disclaimer,
                  style: new TextStyle(fontSize: 20.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
