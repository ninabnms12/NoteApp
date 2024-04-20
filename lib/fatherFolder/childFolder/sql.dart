import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class Sqldb {
  // التحقق من انشاء القاعدة
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      return await initialDb();
    } else {
      return _db;
    }
  }

// //----------------------------------------------------------------------------------------------------------------------------//
//                                     // انشاء قاعدة البيانات

  initialDb() async {
    // getDatabasesPath()---> Get the default databases location (PATH)

    String databasePath = await getDatabasesPath();

    //(join(  اسم قاعدة البيانات, المسار)  path يعني اسم قاعدة اليانات و اين سوف يتم انشاءها

    String path = join(databasePath, 'Alia.db');

    /* openDatabase (   (join( المسار , اسم قاعدة البيانات )  , oncreate(انشاء جدول)  ,  version(الاصدار)  );
       انشاء قاعدة البيانات عن طريق الوظيفة openDatabase() تستقبل 3 parameters */

    Database Mydb = await openDatabase(path,
        onCreate: _oncreate, version: 3, onUpgrade: _onupgrade);

    return Mydb;
  }

  //   version    كل ما تم تغير   onUpgrade تم استدعاء

  _onupgrade(Database db, int oldVersion, int newversion) {
    print(" onUpgrade: ==========================");
  }

  //  يتم استدعاؤها مرة واحدة فقط وظيفتها انشاء جدول oncreate()
  _oncreate(Database db, int version) async {
    await db.execute(
        ' CREATE TABLE note (  "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT , "notes" TEXT  )');

    // اختيارية نضعها فقط لمعرفة ادا ما تم انشاء او لا
    print("ONCREATE: =================== ");
  }

  // read Data

  readData(String sql) async {
    Database? mydb = await db;

    List<Map> reponse = await mydb!.rawQuery(sql);

    return reponse;
  }

  // Insert Data

  Insertdata(sql) async {
    Database? mydb = await db;

    int reponse = await mydb!.rawInsert(sql);

    return reponse;
  }

  //  update data

  Updatedata(String sql) async {
    Database? mydb = await db;
// تأكد من صحة الاستعلام
    int reponse = await mydb!.rawUpdate(sql);
    print(sql);

    return reponse;
  }

  // Delete Data

  deletdata(String sql) async {
    Database? mydb = await db;
    int reponse = await mydb!.rawDelete(sql);

    return reponse;
  }

  // ====================================================================================================

  // read Data 2

  read(String table) async {
    Database? mydb = await db;

    List<Map> reponse = await mydb!.query(table);

    return reponse;
  }

  // Insert Data 2

  Insert(String table, Map<String, Object?> values) async {
    Database? mydb = await db;

    int reponse = await mydb!.insert(table, values);

    return reponse;
  }

  //  update data 2

  update(String table, Map<String, Object?> values) async {
    Database? mydb = await db;
    int reponse =
        await mydb!.update(table, values, where: 'id=?', whereArgs: ['id']);

    return reponse;
  }

  // //
  // Future<int> update2(int id, String? note) async {
  //   Database? mydb = await db;
  //   final data = {'notes': note};
  //   final reponse =
  //       await mydb!.update('note', data, where: "id = ?", whereArgs: ['id']);

  //   return reponse;
  // }

  // Future<int> update3(data) async {
  //   Database? mydb = await db;

  //   final reponse = await mydb!
  //       .update('note', data.toMAP(), where: "id = ?", whereArgs: [data.id]);

  //   return reponse;
  // }

  // Delete Data 2
  deletd(String table, String? MYwhere) async {
    Database? mydb = await db;
    int reponse = await mydb!.delete(table, where: MYwhere);

    return reponse;
  }
}
