import 'package:flutter/material.dart';
import 'package:frontend_molileo/screens/result_screen.dart';
import 'models/mole.dart';
import 'screens/mole_overview_screen.dart';
import 'screens/camera_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Molileo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Raleway',
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Text('Molileo',
                  style: new TextStyle(
                      fontSize: 36.0, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Text(
                  'You can start right away by analyzing a mole or create a profile first.',
                  style: new TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center),
            ),
            SizedBox(height: 80.0),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ButtonTheme(
                      minWidth: 160.0,
                      height: 70.0,
                      child: RaisedButton(
                        child: new Text('Check mole'),
                        padding: const EdgeInsets.all(10.0),
                        textColor: Colors.white,
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CameraScreen()),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    ButtonTheme(
                      minWidth: 160.0,
                      height: 70.0,
                      child: RaisedButton(
                        child: new Text('Profile'),
                        padding: const EdgeInsets.all(10.0),
                        textColor: Colors.white,
                        color: Colors.blue,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ButtonTheme(
                      minWidth: 160.0,
                      height: 70.0,
                      child: RaisedButton(
                        child: new Text('Overview'),
                        padding: const EdgeInsets.all(10.0),
                        textColor: Colors.white,
                        color: Colors.blue,
                        onPressed: () {
                          print("Add");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MoleOverviewScreen()));
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    ButtonTheme(
                      minWidth: 160.0,
                      height: 70.0,
                      child: RaisedButton(
                        child: new Text('Information'),
                        padding: const EdgeInsets.all(10.0),
                        textColor: Colors.white,
                        color: Colors.blue,
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
