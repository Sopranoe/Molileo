import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend_molileo/db/DatabaseHelper.dart';
import 'package:frontend_molileo/models/mole-detail.dart';
import 'package:frontend_molileo/models/mole-location.dart';
import 'package:frontend_molileo/models/mole.dart';
import 'package:frontend_molileo/screens/mole_history_screen.dart';
import 'package:frontend_molileo/helper/textHelper.dart';
import 'package:frontend_molileo/view/AppBar.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class DetailScreen extends StatefulWidget {
  final Mole mole;
  final MoleDetail moleDetail;
  // final int index;

  DetailScreen({this.moleDetail, this.mole});

  DetailScreenState createState() => new DetailScreenState();
}

class DetailScreenState extends State<DetailScreen> {
  DatabaseHelper helper = DatabaseHelper();
  Color riskColor;
  String riskText;
  final myController = TextEditingController();
  MoleLocation _selectedLocation;
  bool onCreate = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    helper.close();

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

    this._selectedLocation = widget.mole == null
        ? this._selectedLocation
        : MoleLocationHelper.toMoleLocation(widget.mole.moleLocation);
    print(this._selectedLocation);
  }

  Widget build(BuildContext context) {
    loadLocationList();
    _resolveRisk();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Column(
          children: <Widget>[
            Text(
              'Molileo',
              style: TextStyle(color: Colors.black, fontSize: 25.0),
              textAlign: TextAlign.center,
            ),
            Text(
              _setSubtitle(),
              style: TextStyle(color: Colors.black38, fontSize: 12.0),
              textAlign: TextAlign.center,
            )
          ],
        ),
        automaticallyImplyLeading: true,
        leading: BackButton(
            color: Colors.black,
            onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MoleHistory(mole: widget.mole)))
                }),
        centerTitle: true,
        backgroundColor: Colors.grey[100],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 10.0),
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                  child: Image.file(File(widget.moleDetail.imagePath),
                      fit: BoxFit.cover)),
              SizedBox(height: 10.0),
              Text(
                'NAME',
                style: TextStyle(
                  color: Colors.grey,
                  letterSpacing: 2.0,
                ),
              ),
              TextField(
                decoration: InputDecoration(
                    hintText:
                        widget.mole == null ? 'Enter name' : widget.mole.name),
                enabled: widget.mole != null ? false : true,
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
                enabled: widget.mole != null ? false : true,
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
                hint: Text('Select Location'),
                disabledHint:
                    Text(MoleLocationHelper.getValue(_selectedLocation)),
                items: locationList,
                value: _selectedLocation,
                onChanged: setDropdown(),
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
              SizedBox(height: 10.0),
              Text(
                this.riskText,
                style: TextStyle(
                  letterSpacing: 2.0,
                  color: Colors.grey[500],
                  fontSize: 10.0,
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: null,
      // FloatingActionButton(
      //   child: Icon(Icons.save, color: Colors.grey),
      //   backgroundColor: Colors.white,
      //   onPressed: () {
      //     this.onCreate = widget.mole == null ? true : false;
      //     if (this.onCreate) {
      //       creatNewMole();
      //     } else {
      //       updateMole();
      //     }
      //   },
      // ),
    );
  }

  void _resolveRisk() {
    switch (widget.moleDetail.riskStatus) {
      case 'Low risk':
        this.riskColor = Colors.lightGreen;
        this.riskText = lowRiskText;
        break;
      case 'Potential risk':
        this.riskColor = Colors.amberAccent[200];
        this.riskText = potentialRiskText;
        break;
      case 'High risk':
        this.riskColor = Colors.orange;
        this.riskText = highRiskText;
        break;
      case 'Very high risk':
        this.riskColor = Colors.red;
        this.riskText = veryHighRiskText;
        break;
    }
  }

  setDropdown() {
    return widget.mole != null
        ? null
        : (value) {
            setState(() {
              _selectedLocation = value;
            });
          };
  }

  creatNewMole() {
    Mole newMole = new Mole(uuid.v1(), myController.text, [],
        MoleLocationHelper.getValue(_selectedLocation));
    newMole.addMoleDetail(widget.moleDetail);
    this._saveMole(newMole);

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MoleHistory(mole: newMole)));
  }

  updateMole() {
    // if (myController.text != null || myController.text.length > 0) {
    //   widget.mole.name = myController.text;
    //   helper.updateMole(widget.mole.id, widget.mole);
    // }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MoleHistory(mole: widget.mole)));
  }

  void _saveMole(Mole mole) async {
    print(this.helper);
    this.helper.save(mole);
  }

  _setSubtitle() {
    return (widget.mole == null) ? 'Create new Mole' : widget.mole.name;
  }
}
