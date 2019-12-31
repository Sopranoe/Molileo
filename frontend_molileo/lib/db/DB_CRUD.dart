import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:frontend_molileo/models/Photo.dart';

class DB_CRUD {

  static Database _db;
  static const String ID = 'id';
  static const String NAME = 'name';
  static const String TABLE = 'MolesTable';
  static const String DB_NAME = 'molileo.db';

  Future<Database> get db async {
    if (null != _db) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }
  initDB() async {
    io.Directory molesDir = await getApplicationDocumentsDirectory();
    String path =  join(molesDir.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE $TABLE ($ID INTEGER, $NAME TEXT)');
  }

  Future<Photo> save(Photo photo) async {
    var dbClient = await db;
    photo.id = await dbClient.insert(TABLE, photo.toMap());
    return photo;
  }

  Future<List<Photo>> getPhotos() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE, columns: [ID, NAME]);
    List<Photo> photos = [];
    if(maps.length > 0) {
      for(Map map in maps) {
        photos.add(Photo.fromMap(map));
      }
    }
    return photos;
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}