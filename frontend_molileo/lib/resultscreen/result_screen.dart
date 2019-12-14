import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend_molileo/addmolescreen/add_mole_screen.dart';
import 'package:frontend_molileo/models/mole/mole-location.dart';
import 'package:frontend_molileo/models/mole/mole.dart';
import 'dart:math';
import 'package:frontend_molileo/models/mole/mole-location.dart';
import 'package:frontend_molileo/models/mole/risk-status.dart';
import 'package:frontend_molileo/models/mole/risk-status.dart';
import 'package:frontend_molileo/resultscreen/menuConstants.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class ResultImageScreen extends StatefulWidget {
  final String imagePath;

  ResultImageScreen({this.imagePath});

  @override
  _ResultImageScreenState createState() => _ResultImageScreenState();
}

class _ResultImageScreenState extends State<ResultImageScreen> {
  String riskTitle;
  String riskText;
  Color riskColor;

  void initState() {
    super.initState();
    this._resolveRisk();
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
    final _random = new Random();
    int min = 1;
    int max = 5;
    switch (min + _random.nextInt(max - min)) {
      case 1:
        this.riskColor = Colors.lightGreen;
        this.riskTitle = 'Low Risk';
        this.riskText =
            'Our analysis resulted in a potentially low risk of skin cancer from this mole. To keep an eye on this mole for further changes you can add it to the history overview and track its changes';
        break;
      case 2:
        this.riskColor = Colors.yellow;
        this.riskTitle = 'Potential Risk';
        this.riskText =
            'Our analysis resulted in a potential risk of skin cancer from this mole. To keep an eye on this mole for further changes you can add it to the history overview and track its changes';
        break;
      case 3:
        this.riskColor = Colors.orange;
        this.riskTitle = 'High Risk';
        this.riskText =
            'Our analysis resulted in a potentially high risk of skin cancer from this mole. To keep an eye on this mole for further changes you can add it to the history overview and track its changes';
        break;
      case 4:
        this.riskColor = Colors.red;
        this.riskTitle = 'Very high Risk';
        this.riskText =
            'Our analysis resulted in a potentially very high risk of skin cancer from this mole. To keep an eye on this mole for further changes you can add it to the history overview and track its changes';
        break;
    }
  }

  void choiceActions(String choice) {
    if (choice == MenuConstants.CreateMole) {
      print("Create");
    } else if (choice == MenuConstants.AddMole) {
      print("Add");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddMoleScreen(
                  newMole: new Mole(
                      uuid.v1(),
                      'Mole1',
                      widget.imagePath,
                      new DateTime.now(),
                      MoleLocationHelper.getValue(MoleLocation.rightArm),
                      RiskStatusHelper.getValue(RiskStatus.lowRisk)))));
    }
  }
}
