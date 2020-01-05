import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend_molileo/models/mole-detail.dart';
import 'package:frontend_molileo/models/mole.dart';
import 'package:frontend_molileo/screens/mole_history_screen.dart';
import 'package:frontend_molileo/mockdata.dart';
import 'package:localstorage/localstorage.dart';
import 'package:path_provider/path_provider.dart';

import '../main.dart';

class MoleOverviewScreen extends StatefulWidget {
  final MoleDetail moleDetail;
  final Mole mole;

  MoleOverviewScreen({this.moleDetail, this.mole});

  @override
  _MoleOverviewScreenState createState() => _MoleOverviewScreenState();
}

class _MoleOverviewScreenState extends State<MoleOverviewScreen> {
  final LocalStorage storage = new LocalStorage('storage');
  List<Mole> moleList = [];
  void initState() {
    super.initState();
    if (storage.getItem('mole_list') != null) {
      print('get mole list');
      // this.moleList = this.storage.getItem('mole_list');
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    print('save mole list');
    // this.storage.setItem('mole_list', moleList);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    addNewMole();
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

  addNewMole() {
    if (widget.mole != null) {
      this.moleList.add(widget.mole);
      // data.add(widget.mole.toJson());
    }
  }

  click(i) {
    print("next... " + i.toString());
    // for (var m in data[i]) {
    //   ml.add(Mole.fromJson(m));
    // }
    this.moleList[i].moleDetails.add(widget.moleDetail);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MoleHistory(mole: this.moleList[i])));
  }

  _read() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/database.txt');
      String text = await file.readAsString();
      print(text);
    } catch (e) {
      print("Couldn't read file");
    }
  }

  _save() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/database.txt');
    final text = 'Hello World!';
    // final text = this.moleList.toString();
    await file.writeAsString(text);
    print('saved ' + '${directory.path}/database.txt');
  }
}
