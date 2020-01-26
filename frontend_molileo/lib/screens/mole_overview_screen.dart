import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend_molileo/db/DatabaseHelper.dart';
import 'package:frontend_molileo/models/mole-detail.dart';
import 'package:frontend_molileo/models/mole.dart';
import 'package:frontend_molileo/screens/mole_history_screen.dart';
import 'package:frontend_molileo/view/AppBar.dart';

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
    helper.close();
  }

  @override
  Widget build(BuildContext context) {
    if (moleList == null) {
      moleList = List<Mole>();
      _getData();
    }
    return Scaffold(
        appBar: appBarWithAction('Molileo', _setSubtitle(), context, 'home'),
        body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 8.0 / 12.0,
          crossAxisCount: 3,
          children: List.generate(this.moleList.length, (index) {
            return Center(
                child: Column(
              children: <Widget>[
                InkResponse(
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
        )
        // )
        );
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
    helper = DatabaseHelper();
    // print("get Data");
    // this.moleList = await helper.getMoles();
    // print(this.moleList.length);

    helper.initDB().then((database) {
      helper.getMoles().then((list) => {
            setState(() {
              this.moleList = list;
            })
          });
    });
  }

  _setSubtitle() {
    return (widget.moleDetail != null)
        ? 'Select mole that it should be added to'
        : 'Overview';
  }
}
