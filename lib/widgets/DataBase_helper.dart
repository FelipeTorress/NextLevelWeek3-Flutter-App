import 'package:happy_app/widgets/Orphanage.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DbHelper {

  static final DbHelper _instance = DbHelper.internal();

  factory DbHelper() => _instance;

  DbHelper.internal();

  Database _db;

  Future<Database> get db async {
    if(_db != null){
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "contactsNew.db");

    return await openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async {
      await db.execute(
         """ CREATE TABLE orphanages ( 
         id INTEGER PRIMARY KEY AUTOINCREMENT, 
         lat TEXT, 
         lng TEXT, 
         name TEXT,
         about TEXT,
         whatsapp TEXT,
         images TEXT,
         instructions TEXT,
         opening_hour TEXT,
         open_on_weekends TEXT
      )"""
      );
    });
  }

  Future<List> getAllOrphanages() async {
    try{
      Database dbContact = await db;
      List listMap = await dbContact.rawQuery("SELECT * FROM orphanages");
      List<Orphanage> listContact = List();
      for(Map m in listMap){
        listContact.add(Orphanage.fromMap(m));
      }
      return listContact;
    }catch(error){
      print(error);
      return null;
    }
  }

  Future<Orphanage> getOrphanage(int id) async {
    try{
      Database dbContact = await db;
      List<Map> maps = await dbContact.query('orphanages',
          columns: ['id', 'lat', 'lng', 'name', 'about', 'whatsapp', 'images', 'instructions' , 'opening_hour', 'open_on_weekends'],
          where: "$id = ?",
          whereArgs: [id]);
      if(maps.length > 0){
        return Orphanage.fromMap(maps.first);
      } else {
        return null;
      }
    }catch(error){
      print(error);
      return null;
    }
  }

  Future<Orphanage> saveOrphanage(Orphanage orphanage) async {
   try{
     Database dbContact = await db;
     orphanage.id = await dbContact.insert("orphanages", orphanage.toMap());
     return orphanage;
   }catch(error){
     print(error);
     return null;
   }
  }

  Future close() async {
    Database dbContact = await db;
    dbContact.close();
  }
}