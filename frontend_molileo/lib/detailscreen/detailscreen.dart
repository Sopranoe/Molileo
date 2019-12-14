import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  DetailScreenState createState() => new DetailScreenState();
}

class DetailScreenState extends State<DetailScreen> {
  int _selectedLocation = 0;

  List<DropdownMenuItem<int>> locationList = [];

  void loadLocationList() {
    locationList = [];
    locationList.add(new DropdownMenuItem(
      child: new Text('Left arm'),
      value: 0,
    ));
    locationList.add(new DropdownMenuItem(
      child: new Text('Right arm'),
      value: 1,
    ));
    locationList.add(new DropdownMenuItem(
      child: new Text('Left chest'),
      value: 2,
    ));
    locationList.add(new DropdownMenuItem(
      child: new Text('Right chest'),
      value: 3,
    ));
    locationList.add(new DropdownMenuItem(
      child: new Text('stomach'),
      value: 4,
    ));
    locationList.add(new DropdownMenuItem(
      child: new Text('Upper back'),
      value: 5,
    ));
    locationList.add(new DropdownMenuItem(
      child: new Text('Lower back'),
      value: 6,
    ));
    locationList.add(new DropdownMenuItem(
      child: new Text('Left leg'),
      value: 7,
    ));
    locationList.add(new DropdownMenuItem(
      child: new Text('Right leg'),
      value: 8,
    ));
  }

  Widget build(BuildContext context) {
    loadLocationList();
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
                child: Image(
                  image: AssetImage('assets/mole1.jpg'),
                  width: 250.0,
                ),
              ),
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
                decoration: InputDecoration(hintText: '01.01.2019'),
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
                'Potential Risk',
                style: TextStyle(
                  color: Colors.amberAccent[200],
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
        onPressed: () {},
      ),
    );
  }
}
