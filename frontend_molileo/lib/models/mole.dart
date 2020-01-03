import 'package:frontend_molileo/models/mole-detail.dart';

class Mole {
  final String id;
  final String name;
  List<MoleDetail> moleDetails;
  final String moleLocation;

  Mole(this.id, this.name, this.moleLocation);

  Mole.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        moleDetails = json['moleDetails'],
        moleLocation = json['moleLocation'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'moleDetails': moleDetails,
        'moleLocation': moleLocation
      };
}
