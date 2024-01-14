import 'dart:io';

import 'package:exercise_tracking_app/constants.dart';
import 'package:exercise_tracking_app/widgets/home_page/running_summary_data_point.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class RunningSummary extends StatefulWidget {
  const RunningSummary({super.key});

  @override
  State<RunningSummary> createState() => _RunningSummaryState();
}

class _RunningSummaryState extends State<RunningSummary> {
  bool _loading = true;
  List<RunningSummaryDataPoint> _dataPoints = [];

  @override
  void initState() {
    super.initState();
    updateRunningSummary();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const Text("Fetching your insane running speeds...")
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _dataPoints,
              ),
            ),
          );
  }

  void updateRunningSummary() async {
    setState(() {
      _loading = true;
    });

    Database db = await openDatabase(dbFileName);

    var dataQuery = await db.rawQuery("SELECT * FROM runs");

    double totalDistance = calculateTotalDistance(dataQuery);
    double totalDuration = calculateTotalDuration(dataQuery);
    double avgSpeed = calculateAvgSpeed(totalDistance, totalDuration);

    _dataPoints = [
      RunningSummaryDataPoint(
          icon: const Icon(Icons.directions_run_rounded),
          title: "Total Distance",
          value: totalDistance,
          unit: "km"),
      RunningSummaryDataPoint(
          icon: const Icon(Icons.timer_rounded),
          title: "Total Duration",
          value: totalDuration,
          unit: "s"),
      RunningSummaryDataPoint(
          icon: const Icon(Icons.speed_rounded),
          title: "Average Speed",
          value: avgSpeed,
          unit: "km/h"),
    ];

    print("Fake loading start");
    sleep(const Duration(seconds: 1));
    print("Fake loading end");

    setState(() {
      _loading = false;
    });
  }

  double calculateTotalDistance(List<Map<String, dynamic>> data) {
    double totalDistance = 0;

    for (var row in data) {
      totalDistance += double.parse(row["distance"].toString());
    }

    return totalDistance;
  }

  double calculateTotalDuration(List<Map<String, dynamic>> data) {
    double totalDuration = 0;

    for (var row in data) {
      totalDuration += double.parse(row["duration"].toString());
    }

    return totalDuration;
  }

  double calculateAvgSpeed(double distance, double duration) {
    return distance / (duration / 3600);
  }
}
