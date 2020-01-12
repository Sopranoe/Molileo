import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend_molileo/db/DatabaseHelper.dart';
import 'package:frontend_molileo/models/mole-detail.dart';
import 'package:frontend_molileo/models/mole-location.dart';
import 'package:frontend_molileo/models/mole.dart';
import 'package:frontend_molileo/models/risk-status.dart';
import 'package:frontend_molileo/screens/mole_history_screen.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class DetailScreen extends StatefulWidget {
  final MoleDetail moleDetail;

  DetailScreen({this.moleDetail});

  DetailScreenState createState() => new DetailScreenState();
}

class DetailScreenState extends State<DetailScreen> {
  DatabaseHelper helper = DatabaseHelper();
  Color riskColor;
  final myController = TextEditingController();
  MoleLocation _selectedLocation;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  List<DropdownMenuItem<MoleLocation>> locationList = [];

  void loadLocationList() {
    locationList = [];
    locationList.add(new DropdownMenuItem(
      child: new Text(MoleLocationHelper.getValue(MoleLocation.leftArm)),
      value: MoleLocation.leftArm,
    ));
    locationList.add(new DropdownMenuItem(
      child: new Text(MoleLocationHelper.getValue(MoleLocation.rightArm)),
      value: MoleLocation.rightArm,
    ));
    locationList.add(new DropdownMenuItem(
      child: new Text(MoleLocationHelper.getValue(MoleLocation.leftChest)),
      value: MoleLocation.leftChest,
    ));
    locationList.add(new DropdownMenuItem(
      child: new Text(MoleLocationHelper.getValue(MoleLocation.rightChest)),
      value: MoleLocation.rightChest,
    ));
    locationList.add(new DropdownMenuItem(
      child: new Text(MoleLocationHelper.getValue(MoleLocation.stomach)),
      value: MoleLocation.stomach,
    ));
    locationList.add(new DropdownMenuItem(
      child: new Text(MoleLocationHelper.getValue(MoleLocation.upperBack)),
      value: MoleLocation.upperBack,
    ));
    locationList.add(new DropdownMenuItem(
      child: new Text(MoleLocationHelper.getValue(MoleLocation.lowerBack)),
      value: MoleLocation.lowerBack,
    ));
    locationList.add(new DropdownMenuItem(
      child: new Text(MoleLocationHelper.getValue(MoleLocation.leftLeg)),
      value: MoleLocation.leftLeg,
    ));
    locationList.add(new DropdownMenuItem(
      child: new Text(MoleLocationHelper.getValue(MoleLocation.rightLeg)),
      value: MoleLocation.rightLeg,
    ));
  }

  Widget build(BuildContext context) {
    loadLocationList();
    _resolveRisk();
    return Scaffold(
      appBar: new AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: const Text('Molileo',
            style: TextStyle(color: Colors.black, fontSize: 25.0)),
        centerTitle: true,
        backgroundColor: Colors.grey[100],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                  child: Image.file(File(widget.moleDetail.imagePath),
                      fit: BoxFit.cover)),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text('Create new mole',
                      style: new TextStyle(fontSize: 25.0),
                      textAlign: TextAlign.center),
                ),
              ),
              Text(
                'NAME',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                ),
              ),
              TextField(
                decoration: InputDecoration(hintText: 'Enter name'),
                controller: myController,
              ),
              SizedBox(height: 20.0),
              Text(
                'DATE',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                ),
              ),
              TextField(
                decoration: InputDecoration(
                    hintText: widget.moleDetail.date.substring(0, 10)),
              ),
              SizedBox(height: 20.0),
              Text(
                'LOCATION',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                ),
              ),
              DropdownButton(
                hint: new Text('Select Location'),
                items: locationList,
                value: _selectedLocation,
                onChanged: (value) {
                  setState(() {
                    _selectedLocation = value;
                  });
                },
                isExpanded: true,
              ),
              SizedBox(height: 20.0),
              Text(
                'STATUS',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                ),
              ),
              Text(
                widget.moleDetail.riskStatus,
                style: TextStyle(
                  color: this.riskColor,
                  letterSpacing: 2.0,
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save, color: Colors.grey),
        backgroundColor: Colors.white,
        onPressed: () {
          Mole newMole = new Mole(uuid.v1(), myController.text, [],
              MoleLocationHelper.getValue(_selectedLocation));
          // newMole.moleDetails = [];
          newMole.addMoleDetail(widget.moleDetail);
          this._saveMole(newMole);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MoleHistory(mole: newMole)));
        },
      ),
    );
  }

  void _resolveRisk() {
    switch (widget.moleDetail.riskStatus) {
      case 'Low risk':
        this.riskColor = Colors.lightGreen;
        break;
      case 'Potential risk':
        this.riskColor = Colors.amberAccent[200];
        break;
      case 'High risk':
        this.riskColor = Colors.orange;
        break;
      case 'Very high risk':
        this.riskColor = Colors.red;
        break;
    }
  }

  void _saveMole(Mole mole) async {
    print(this.helper);
    this.helper.save(mole);
  }
}
