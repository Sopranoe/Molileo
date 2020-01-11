class MoleDetail {
  final String date;
  // final DateTime date;
  final String imagePath;
  final String riskStatus;

  MoleDetail(this.date, this.imagePath, this.riskStatus);

  MoleDetail.fromJson(Map<String, dynamic> json)
      : date = json['date'],
        imagePath = json['imagePath'],
        riskStatus = json['riskStatus'];

  Map<String, dynamic> toJson() =>
      {'date': date, 'imagePath': imagePath, 'riskStatus': riskStatus};
}
