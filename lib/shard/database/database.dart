// ignore_for_file: avoid_print

import 'package:quran_app/models/azkar_model.dart';
import 'package:sqflite/sqflite.dart';

late Database database;

class DataBase {
  
  createDB() async {
    await openDatabase(
      "a4.db",
      version: 1,
      onCreate: (db, version) async {
        print("database is created");
        try {
          String t1 = "create table favzekr(id int ,category string);";
          await db.execute(t1);
        } catch (e) {
          print("erorr is " + e.toString());
        }
      },
      onOpen: (db) {},
    ).then((value) {
      database = value;
    });
  }

  Future<List<Map>> getFavZekr() async {
    String sql = "select * from favzekr";
    // return list of map of persons
    return await database.rawQuery(sql);
  }

  Future<int> insertFavZekr(Zekr z) async {
    return await database.insert("favzekr", z.toDB());
  }

  deletFavZekr(Zekr z) async {
    await database.transaction((txn) async {
      database
          .rawDelete(
              'DELETE FROM favzekr WHERE id = ${z.id} and category=\'${z.mainCategory ?? z.category}\' ')
          .then((value) {
        print("peson ${z.id} in table favzekr deleted successfully");
      }).catchError((error) {
        print("deleting peson ${z.id} in table favzekr error: $error");
      });
    });
  }
}
