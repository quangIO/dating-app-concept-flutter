import 'dart:async';
// import 'dart:io';

import 'package:datingsample/screen/MainScreen.dart';
import 'package:flutter/material.dart';
// import 'dart:isolate';
// import 'package:android_job_scheduler/android_job_scheduler.dart';
// import 'package:location/location.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';



/*
void printHello() async {
  final DateTime now = new DateTime.now();
  final int isolateId = Isolate.current.hashCode;
  final location = new Location();
  var currentLocation = <String, double>{};

  try {
    currentLocation = await location.getLocation;
  } on Exception {
    currentLocation = null;
  }

  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String path = join(documentsDirectory.path, "demo.db");

  await deleteDatabase(path);

  Database database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            "CREATE TABLE gps_offline (lat REAL, lng REAL, ts INT, id INTEGER PRIMARY KEY)");
      });
  await database.execute("INSERT INTO gps_offline VALUES (${currentLocation['latitude']}, ${currentLocation['longitude']}, ${now.millisecondsSinceEpoch}, NULL)");

  final rs = await database.rawQuery('SELECT * FROM gps_offline ORDER BY id DESC');
  await database.close();

  print(rs);
  // print("[$now] $currentLocation Hello, world! isolate=$isolateId");
}
*/


Future<Null> main() async {
  runApp(new MyApp());
  const period = 10;

  // AndroidJobScheduler.scheduleEvery(const Duration(seconds: period), 42, printHello);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData.light(),
      title: 'Flutter Demo',
      home: new MainScreen(),
    );
  }
}