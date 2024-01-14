import 'package:exercise_tracking_app/constants.dart';
import 'package:exercise_tracking_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(const ExerciseTrackingApp());
  initApp();
}

void initApp() async {
  Database db = await openDatabase(dbFileName);

  db.execute(
      "CREATE TABLE IF NOT EXISTS settings (settings TEXT PRIMARY KEY, value TEXT)");
  db.execute(
      "CREATE TABLE IF NOT EXISTS runs (id INTEGER PRIMARY KEY, distance REAL, duration REAL, avgSpeed REAL)");
  db.execute(
      "INSERT OR IGNORE INTO runs (id, distance, duration, avgSpeed) VALUES (1, 10, 3600, 2.7)");
  db.execute(
      "INSERT OR IGNORE INTO runs (id, distance, duration, avgSpeed) VALUES (2, 5, 1800, 2.7)");
  db.execute(
      "INSERT OR IGNORE INTO runs (id, distance, duration, avgSpeed) VALUES (3, 2, 720, 2.7)");

  db.execute(
      "INSERT OR IGNORE INTO settings (settings, value) VALUES ('firstLaunch', 'true')");
}

class ExerciseTrackingApp extends StatelessWidget {
  const ExerciseTrackingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: defaultFont),
      home: const HomePage(),
    );
  }
}
