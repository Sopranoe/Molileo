import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend_molileo/models/mole.dart';

import 'mole_overview_screen.dart';

class MoleHistory extends StatefulWidget {
  final Mole mole;

  MoleHistory({this.mole});

  @override
  _MoleHistoryState createState() => _MoleHistoryState();
}

class _MoleHistoryState extends State<MoleHistory> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MoleOverviewScreen()));
        },
        child: Scaffold(
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
              children: List.generate(widget.mole.moleDetails.length, (index) {
                return Center(
                    child: Column(
                  children: <Widget>[
                    Image.file(
                      File(widget.mole.moleDetails[index].imagePath),
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
                            backgroundColor: this.getRiskColor(
                                widget.mole.moleDetails[index].riskStatus),
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          widget.mole.moleDetails[index].date.substring(0, 10) +
                              ', $index',
                          style: TextStyle(fontSize: 10.0, color: Colors.black),
                        ),
                      ],
                    )
                  ],
                ));
              }),
            )));
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
