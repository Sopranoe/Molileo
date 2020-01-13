class MoleDetail {
  final String _date;
  // final DateTime date;
  final String _imagePath;
  final String _riskStatus;

  MoleDetail(this._date, this._imagePath, this._riskStatus);

  String get date => _date;
  String get imagePath => _imagePath;
  String get riskStatus => _riskStatus;

  MoleDetail.fromJson(Map<String, dynamic> json)
      : _date = json['date'],
        _imagePath = json['imagePath'],
        _riskStatus = json['riskStatus'];

  Map<String, dynamic> toJson() =>
      {'date': _date, 'imagePath': _imagePath, 'riskStatus': _riskStatus};
}
