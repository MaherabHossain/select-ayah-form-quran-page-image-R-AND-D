import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';

class DbQuran {
  // static var _dbName = 'quran.db';
  static Database? _db;

  static Future _init() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);
    final exist = await databaseExists(path);
    if (!exist) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (e) {
          // //printe.toString());
      }
      ByteData data = await rootBundle.load(join("assets/", _dbName));
      List<int> bytes =
      data.buffer.asInt8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    }
    await openDatabase(path);
    _db = await openDatabase(path);
  }

  static var _dbName = 'ayah_info.db';

  static Future printTableData() async {
    if (_db == null) await _init();
    List<dynamic> whereArguments = [
      8,
    ];
    String whereString =
        'page_number = ? ';
    var res = await _db!
        .query("glyphs",where: whereString, whereArgs: whereArguments,columns: ['MAX(max_x),MAX(max_y),MIN(min_x)']);
    //printres);
    var result = {
      "max_x":res[0]['MAX(max_x)'],
      "max_y":res[0]['MAX(max_y)'],
      "min_x": res[0]['MIN(min_x)']
    };
    return result;
  }
  static findXandYvalueOfAyah(int pageNumber,int ayahNumber,int lineNumber)async{
    ////print"::::::::::::::Find x and y value of a line::::::::::::::::::::::");
    if (_db == null) await _init();
    List<dynamic> whereArguments = [
      8,
      ayahNumber,
      lineNumber
    ];
    String whereString =
        'page_number = ? AND ayah_number = ? AND line_number = ?';
    var res = await _db!
        .query("glyphs",where: whereString, whereArgs: whereArguments,columns: ['MAX(max_x),MAX(max_y),MIN(min_x)']);
    ////printres);
    var result = {
      "max_x":res[0]['MAX(max_x)'],
      "max_y":res[0]['MAX(max_y)'],
      "min_x": res[0]['MIN(min_x)']
    };
    return result;
  }
  static findLineOfAyah(int pageNumber,int ayahNumber)async{
    ////print"Page Number: ${pageNumber} : Ayah number: ${ayahNumber}");
    if (_db == null) await _init();
    List<dynamic> whereArguments = [
      8,
      ayahNumber
    ];
    String whereString =
        'page_number = ? AND ayah_number = ?';
    var line_start = await _db!
        .query("glyphs",where: whereString, whereArgs: whereArguments,columns: ["line_number"],orderBy: "line_number ASC", limit: 1);
    var line_end = await _db!
        .query("glyphs",where: whereString, whereArgs: whereArguments,columns: ["MAX(line_number)"]);
    ////print"Total line number");
    var numOfLine = int.parse(line_end[0]['MAX(line_number)'].toString())-int.parse(line_start[0]['line_number'].toString());
    var result = {
      "ayah_number":ayahNumber,
      "start_ayah":line_start[0]['line_number'],
      "end_ayah":line_end[0]['MAX(line_number)'],
      "number_of_line":numOfLine+1
    };
    //printresult);
    return result;
  }

  static findAyah(double x, double y)async{
    if (_db == null) await _init();
    // List<Map<String, dynamic>> result = await _db.query('SELECT * FROM users');
    // result.forEach((row) => //printrow));
   //  List<Map> resultt = await _db!.rawQuery('SELECT ayah_number FROM glyphs WHERE page_number=8 AND (max_x>=${1500} OR min_x<=${1500}) AND (max_y>=${1000} OR min_y<=${1000})');
   // //print"Hello ressult");
   //
   // //printresultt);
   //  return;
    //printx);
    //printy);
    List<dynamic> whereArguments = [
      8,
      x.toInt(),
      x.toInt(),
      y.toInt(),
      y.toInt(),


    ];
    String whereString =
        'page_number = ? AND (min_x <= ? AND max_x >= ?) AND (min_y <= ? AND max_y >= ?)';
    var result = await _db!
        .query("glyphs",where: whereString, whereArgs: whereArguments,columns: ["ayah_number,position,min_x,max_x,max_y"]);
    //print"important log");
    //printresult.length);
    //printresult);
    //printresult[0]);
    return result[0];

  }
  static getPageData(int pageNumber,int ayahNumber) async {
    if (_db == null) await _init();
    var temp = await _db?.execute("SELECT MAX(column_name) FROM glyphs");
    // //printtemp().toString());

    String whereString = 'type = ?';
    List<dynamic> whereArguments = ["table"];
    var result = await _db!
        .query("glyphs", whereArgs: whereArguments,columns: ["MAX(max_y)"],);
    //printresult.length);
    result.forEach((element) {
      //printelement);
    });

  }
}
