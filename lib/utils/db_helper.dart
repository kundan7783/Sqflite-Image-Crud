import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DbHelper {
  Database? myDB;

  static const String TABLE_TASK = "tasks";
  static const String COLUMN_ID = "id";
  static const String COLUMN_NAME = "name";
  static const String COLUMN_IMAGE_PATH = "image_path";

  Future<Database> getDB() async {

    return myDB ??= await openDB();

    // ye code large tha or uper wala short hai kaam ak hi hai
    if(myDB != null){
      return myDB!;
    }
    else{
      myDB= await openDB();
      return myDB!;
    }
  }
  Future<Database> openDB() async {
   String path= await getDatabasesPath();
   String pathName= join(path,"my.db");
   return openDatabase(pathName,onCreate: (db, version) {
      db.execute("CREATE TABLE $TABLE_TASK($COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT,$COLUMN_NAME TEXT,$COLUMN_IMAGE_PATH TEXT)");
   },version: 1);
  }
  Future<bool> insertData(Map<String,dynamic> data) async {
    var db = await getDB();
    int success = await db.insert(TABLE_TASK, data);
    return success > 0;
  }
  Future<List<Map<String,dynamic>>> fetchAllData() async {
    var db = await getDB();
    return db.query(TABLE_TASK);
  }
  Future<void> updateData(Map<String,dynamic> data,{required int id}) async {
    var db = await getDB();
    db.update(TABLE_TASK, data,where: "$COLUMN_ID =?",whereArgs: [id]);
  }
  Future<bool> deleteData({required int id}) async {
    var db = await getDB();
    int delete= await db.delete(TABLE_TASK,where: "$COLUMN_ID =?",whereArgs: [id]);
    return delete>0;
  }
}