import 'dart:async';
import 'dart:io';

import 'package:datingsample/screen/MainScreen.dart';
import 'package:flutter/material.dart';
import 'dart:isolate';
import 'package:android_job_scheduler/android_job_scheduler.dart';
import 'package:location/location.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';



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

  print("[$now] $currentLocation Hello, world! isolate=$isolateId");
}


Future<Null> main() async {
  runApp(new MyApp());
  const period = 10;

  await AndroidJobScheduler.scheduleEvery(
      const Duration(seconds: period), 42, printHello);
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