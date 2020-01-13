import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend_molileo/db/DatabaseHelper.dart';
import 'package:frontend_molileo/models/mole-detail.dart';
import 'package:frontend_molileo/models/mole.dart';
import 'package:frontend_molileo/screens/mole_history_screen.dart';
import 'package:sqflite/sqlite_api.dart';

import '../main.dart';

class MoleOverviewScreen extends StatefulWidget {
  final MoleDetail moleDetail;

  MoleOverviewScreen({this.moleDetail});

  @override
  _MoleOverviewScreenState createState() => _MoleOverviewScreenState();
}

class _MoleOverviewScreenState extends State<MoleOverviewScreen> {
  DatabaseHelper helper = DatabaseHelper();
  List<Mole> moleList;

  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (moleList == null) {
      moleList = List<Mole>();
      _getData();
    }
    return WillPopScope(
        onWillPop: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyHomePage(title: 'Molileo')));
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
              children: List.generate(this.moleList.length, (index) {
                return Center(
                    child: Column(
                  children: <Widget>[
                    new InkResponse(
                        enableFeedback: true,
                        onTap: () => click(index),
                        child: Image.file(
                          File(this.moleList[index].moleDetails[0].imagePath),
                          fit: BoxFit.scaleDown,
                        )),
                    Text(
                      this.moleList[index].name,
                      style: TextStyle(fontSize: 11.0, color: Colors.black),
                    ),
                  ],
                ));
              }),
            )));
  }

  click(i) {
    if (widget.moleDetail != null) {
      this.moleList[i].moleDetails.add(widget.moleDetail);
      helper.updateMoleDetail(this.moleList[i].id, widget.moleDetail);
    }
    // this.moleList[i].moleDetails.add(widget.moleDetail);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MoleHistory(mole: this.moleList[i])));
  }

  _getData() async {
    print("get Data");
    this.moleList = await helper.getMoles();
    print(this.moleList.length);

    helper.initDB().then((database) {
      helper.getMoles().then((list) => {
            setState(() {
              this.moleList = list;
            })
          });
    });
  }
}
