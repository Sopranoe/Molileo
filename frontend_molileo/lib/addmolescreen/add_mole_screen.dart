import 'package:flutter/material.dart';
import 'package:frontend_molileo/models/mole/mole.dart';

class AddMoleScreen extends StatefulWidget {
  final Mole newMole;

  AddMoleScreen({this.newMole});

  @override
  _AddMoleScreenState createState() => _AddMoleScreenState();
}

class _AddMoleScreenState extends State<AddMoleScreen> {
  void initState() {
    super.initState();
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
        body: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 3,
          // Generate 100 widgets that display their index in the List.
          children: List.generate(100, (index) {
            return Center(
              child: Text(
                'Item $index',
                style: Theme.of(context).textTheme.headline,
              ),
            );
          }),
        ));
  }
}
