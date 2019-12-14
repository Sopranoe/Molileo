import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend_molileo/models/mole.dart';

class AddMoleScreen extends StatefulWidget {
  final Mole newMole;

  AddMoleScreen({this.newMole});

  @override
  _AddMoleScreenState createState() => _AddMoleScreenState();
}

class _AddMoleScreenState extends State<AddMoleScreen> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          title: const Text('Molileo',
              style: TextStyle(color: Colors.black, fontSize: 25.0)),
          centerTitle: true,
          backgroundColor: Colors.grey[100],
        ),
        body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 8.0 / 12.0,
          crossAxisCount: 3,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(100, (index) {
            return Center(
                child: Column(
              children: <Widget>[
                new InkResponse(
                    enableFeedback: true,
                    onTap: () => click(index),
                    child: Image.file(
                      File(widget.newMole.imagePath),
                      fit: BoxFit.scaleDown,
                    )),
                Text(
                  widget.newMole.name + ', $index',
                  style: TextStyle(fontSize: 11.0, color: Colors.black),
                ),
              ],
            ));
          }),
        ));
  }

  getData(index) {
    return widget.newMole.name;
  }

  click(i) {
    print("next... " + i.toString());
  }
}
