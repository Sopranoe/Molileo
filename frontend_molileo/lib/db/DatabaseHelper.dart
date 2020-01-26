import 'dart:async';
import 'dart:io' as io;
import 'package:frontend_molileo/models/mole-detail.dart';
import 'package:frontend_molileo/models/mole.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _dbCrud;
  static Database _db;

  static const String ID = 'id';
  static const String MOLE_ID = 'moleID';
  static const String NAME = 'name';
  static const String MOLE_LOCATION = 'moleLocation';
  static const String MOLE_TABLE = 'mole';

  static const String DATE = 'date';
  static const String RISK_STATUS = 'riskStatus';
  static const String IMAGE = 'imagePath';
  static const String MOLEDETAIL_TABLE = 'mole_detail';

  static const String DB_NAME = 'mole_database.db';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    print('get databasehelper');
    if (_dbCrud == null) {
      _dbCrud = DatabaseHelper
          ._createInstance(); // This is executed only once, singleton object
    }
    return _dbCrud;
  }

  initDB() async {
    io.Directory molesDir = await getApplicationDocumentsDirectory();
    String path = join(molesDir.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $MOLE_TABLE($ID INTEGER PRIMARY KEY AUTOINCREMENT, $MOLE_ID TEXT , $NAME TEXT, $MOLE_LOCATION TEXT)');
    await db.execute(
        'CREATE TABLE $MOLEDETAIL_TABLE($ID INTEGER PRIMARY KEY AUTOINCREMENT, $DATE TEXT, '
        '$RISK_STATUS TEXT, $IMAGE TEXT, $MOLE_ID TEXT, CONSTRAINT fk_$MOLE_TABLE FOREIGN KEY ($MOLE_ID) REFERENCES $MOLE_TABLE($MOLE_ID))');
  }

  Future<Database> get db async {
    if (null != _db) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  Future<int> save(Mole mole) async {
    var dbClient = await db;

    var moleID = await dbClient.insert(MOLE_TABLE,
        {MOLE_ID: mole.id, NAME: mole.name, MOLE_LOCATION: mole.moleLocation});

    for (MoleDetail moleDetail in mole.moleDetails) {
      await dbClient.insert(MOLEDETAIL_TABLE, {
        DATE: moleDetail.date,
        RISK_STATUS: moleDetail.riskStatus,
        IMAGE: moleDetail.imagePath,
        MOLE_ID: mole.id
      });
    }
    return moleID;
  }

  Future<List<Mole>> getMoles() async {
    List<Mole> moleList = [];

    var dbClient = await db;
    List<Map> moleMaps = await dbClient
        .query(MOLE_TABLE, columns: [MOLE_ID, NAME, MOLE_LOCATION]);
    List<Map> moleDetailMaps = List<Map>();

    if (moleMaps.length > 0) {
      for (Map mole in moleMaps) {
        Mole newMole = Mole.fromJson(mole);

        moleDetailMaps = await dbClient.query(MOLEDETAIL_TABLE,
            columns: [DATE, RISK_STATUS, IMAGE],
            where: '$MOLE_ID = ?',
            whereArgs: [newMole.id]);
        for (Map moleDetail in moleDetailMaps) {
          newMole.addMoleDetail(MoleDetail.fromJson(moleDetail));
        }
        moleList.add(newMole);
      }
    }
    return moleList;
  }

  Future<int> updateMoleDetail(String id, MoleDetail moleDetail) async {
    var dbClient = await db;
    var result = await dbClient.insert(MOLEDETAIL_TABLE, {
      DATE: moleDetail.date,
      RISK_STATUS: moleDetail.riskStatus,
      IMAGE: moleDetail.imagePath,
      MOLE_ID: id
    });
    return result;
  }

  Future<int> deleteMole(String id) async {
    var dbClient = await db;
    await dbClient
        .delete(MOLEDETAIL_TABLE, where: '$MOLE_ID = ?', whereArgs: [id]);
    return await dbClient
        .delete(MOLE_TABLE, where: '$MOLE_ID = ?', whereArgs: [id]);
  }

  Future<int> updateMole(String id, Mole mole) async {
    var dbClient = await db;
    await dbClient.update(
      MOLE_TABLE,
      {NAME: mole.name, MOLE_LOCATION: mole.moleLocation},
      where: '$MOLE_ID',
      whereArgs: [mole.id],
    );
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
