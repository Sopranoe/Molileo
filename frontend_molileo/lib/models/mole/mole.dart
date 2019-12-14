import 'package:frontend_molileo/models/mole/mole-location.dart';
import 'package:frontend_molileo/models/mole/risk-status.dart';

class Mole {
  final String id;
  final String name;
  final String imagePath;
  final DateTime date;
  final String moleLocation;
  final String riskStatus;

  Mole(this.id, this.name, this.imagePath, this.date, this.moleLocation,
      this.riskStatus);

  Mole.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        imagePath = json['imagePath'],
        date = json['date'],
        moleLocation = json['moleLocation'],
        riskStatus = json['riskStatus'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'imagePath': imagePath,
        'date': date,
        'moleLocation': moleLocation,
        'riskStatus': riskStatus
      };
}
