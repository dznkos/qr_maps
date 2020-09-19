
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_maps/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider{

  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {

    if ( _database != null ) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async{

    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join( documentsDirectory.path, 'ScansDB.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE Scans("
          " id INTEGER PRIMARY KEY,"
          " tipo TEXT,"
          " valor TEXT,"
          ")"
        );
      }
    );
  }

  nuevoScanRaw (ScanModel nuevoScan) async{

    final db = await database;

    final res = await db.rawInsert(
      "INSERT INTO Scans (id, tipo, valor)"
      " VALUES ( ${nuevoScan.id}, '${nuevoScan.tipo}', '${nuevoScan.valor}' ) "
    );
  }

  Future<ScanModel> getScanId (int id) async{
    final db = await database;
    final res = await db.query( 'Scans', where: 'id = ?', whereArgs: [id] );
    return res.isNotEmpty ? ScanModel.fromJson( res.first ) : null;
  }

  Future<List<ScanModel>> getTodosScans() async{
    final db = await database;
    final res = await db.query('Scans');
    List<ScanModel> list = res.isNotEmpty
                           ? res.map( (c) => ScanModel.fromJson(c) ).toList()
                           : [];
    return list;
  }

  Future<List<ScanModel>> getScansPorTipo(String tipo) async{
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Scans WHERE tipo='$tipo'");
    List<ScanModel> list = res.isNotEmpty
                           ? res.map( (c) => ScanModel.fromJson(c) ).toList()
                           : [];
    return list;
  }


}