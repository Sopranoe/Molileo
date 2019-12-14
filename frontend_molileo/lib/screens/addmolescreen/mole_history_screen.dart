import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend_molileo/models/mole.dart';

class MoleHistory extends StatefulWidget {
  final List<Mole> moleHistoryList;

  MoleHistory({this.moleHistoryList});

  @override
  _MoleHistoryState createState() => _MoleHistoryState();
}

class _MoleHistoryState extends State<MoleHistory> {
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
                Image.file(
                  File(widget.moleHistoryList[0].imagePath),
                  fit: BoxFit.scaleDown,
                ),
                SizedBox(height: 1.0),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 15.0,
                      height: 15.0,
                      child: FloatingActionButton(
                        heroTag: index.toString(),
                        backgroundColor: this
                            .getRiskColor(widget.moleHistoryList[0].riskStatus),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      widget.moleHistoryList[0].name + ', $index',
                      style: TextStyle(fontSize: 10.0, color: Colors.black),
                    ),
                  ],
                )
              ],
            ));
          }),
        ));
  }

  getRiskColor(risk) {
    if (risk == 'Low risk') {
      return Colors.lightGreen;
    }
    if (risk == 'Potential risk') {
      return Colors.yellow;
    }
    if (risk == 'High risk') {
      return Colors.orange;
    }
    if (risk == 'Very high risk') {
      return Colors.red;
    }
  }
}
