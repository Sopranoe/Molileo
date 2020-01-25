import 'package:frontend_molileo/models/mole-detail.dart';

class Mole {
  final String _id;
  String _name;
  List<MoleDetail> _moleDetails = [];
  final String _moleLocation;

  Mole(this._id, this._name, this._moleDetails, this._moleLocation);

  String get id => _id;
  String get name => _name;
  List<MoleDetail> get moleDetails => _moleDetails;
  String get moleLocation => _moleLocation;

  set name(newName) => _name = newName;

  Mole.fromJson(Map<String, dynamic> json)
      : _id = json['moleID'],
        _name = json['name'],
        _moleDetails = json['moleDetails'],
        _moleLocation = json['moleLocation'];

  Map<String, dynamic> toJson() => {
        'moleID': _id,
        'name': _name,
        'moleDetails': _moleDetails,
        'moleLocation': _moleLocation
      };

  void setMoleDetailsList(List<MoleDetail> md) {
    if (_moleDetails.length > 0) {
      for (var moleDetail in moleDetails) {
        for (var item in md) {
          if (item.date != moleDetail.date) {
            moleDetails.add(item);
          }
        }
      }
    }
  }

  void addMoleDetail(MoleDetail moleDetail) {
    if (_moleDetails == null) {
      _moleDetails = [
        new MoleDetail(
            moleDetail.date, moleDetail.imagePath, moleDetail.riskStatus)
      ];
    } else {
      this._moleDetails.add(moleDetail);
    }
  }
}
