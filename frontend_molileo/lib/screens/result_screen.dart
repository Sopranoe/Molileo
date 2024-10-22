import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend_molileo/models/mole-detail.dart';
import 'package:frontend_molileo/screens/detailscreen.dart';
import 'dart:math';
import 'package:frontend_molileo/models/risk-status.dart';
import 'package:frontend_molileo/screens/menuConstants.dart';
import 'package:frontend_molileo/view/AppBar.dart' as prefix0;

import '../helper/textHelper.dart';
import 'mole_overview_screen.dart';

class ResultImageScreen extends StatefulWidget {
  final String imagePath;
  //final List riskRecognitions;
  final String risk;

  ResultImageScreen({this.imagePath, this.risk});

  @override
  _ResultImageScreenState createState() => _ResultImageScreenState();
}

class _ResultImageScreenState extends State<ResultImageScreen> {
  String riskTitle;
  String riskText;
  Color riskColor;
  RiskStatus risk;

  void initState() {
    super.initState();
    this._resolveRisk();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: prefix0.appBar('Molileo', 'Analytics result'),
      body: Container(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            Expanded(
              key: Key('content'),
              flex: 4,
              child: Container(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                        child: Image.file(File(widget.imagePath),
                            fit: BoxFit.cover)),
                    SizedBox(height: 30.0),
                    Column(children: <Widget>[
                      Row(
                        children: [
                          SizedBox(
                            width: 20.0,
                            height: 20.0,
                            child: FloatingActionButton(
                              backgroundColor: this.riskColor,
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            this.riskTitle,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Text(this.riskText, style: TextStyle(fontSize: 15.0))
                    ]),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: PopupMenuButton<String>(
                      onSelected: choiceActions,
                      itemBuilder: (BuildContext context) {
                        return MenuConstants.menuChoices.map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(choice),
                          );
                        }).toList();
                      },
                      child: Container(
                        height: 54,
                        width: 54,
                        decoration: ShapeDecoration(
                          shape: StadiumBorder(
                            side: BorderSide(color: Colors.grey, width: 2),
                          ),
                        ),
                        child: Icon(Icons.add),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _resolveRisk() {

    switch (widget.risk) {
      case "low risk":
        this.riskColor = Colors.lightGreen;
        this.riskTitle = 'Low Risk';
        this.riskText = lowRiskText;
        this.risk = RiskStatus.lowRisk;
        break;
      case "high risk":
        this.riskColor = Colors.red;
        this.riskTitle = 'High Risk';
        this.riskText = highRiskText;
        this.risk = RiskStatus.highRisk;
        break;
    }
  }

  void choiceActions(String choice) {
    MoleDetail newMoleDetail = new MoleDetail(new DateTime.now().toString(),
        widget.imagePath, RiskStatusHelper.getValue(this.risk));

    if (choice == MenuConstants.CreateMole) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailScreen(moleDetail: newMoleDetail)));
    } else if (choice == MenuConstants.AddMole) {
      print("Add");
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MoleOverviewScreen(moleDetail: newMoleDetail),
          ));
    }
  }
}
