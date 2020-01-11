class Photo {
  int id;
  String name;

  Photo({this.id, this.name});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic> {
      'id': id,
      'name': name
    };
    return map;
  }

  Photo.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
  }
}