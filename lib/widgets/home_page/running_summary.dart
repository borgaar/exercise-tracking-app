import 'dart:io';

import 'package:exercise_tracking_app/constants.dart';
import 'package:exercise_tracking_app/widgets/home_page/running_summary_datapoint.dart.dart';
import 'package:exercise_tracking_app/widgets/home_page/running_summary_item.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class RunningSummary extends StatefulWidget {
  const RunningSummary({super.key});

  @override
  State<RunningSummary> createState() => _RunningSummaryState();
}

class _RunningSummaryState extends State<RunningSummary> {
  bool _loading = true;
  List<RunningSummaryDatapoint> _dataPoints = [];

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
                children: _dataPoints
                    .map((e) => RunningSummaryItem(data: e))
                    .toList(),
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

    const kmsToKmh = 3600;
    double avgSpeed = (totalDistance / totalDuration) * kmsToKmh;

    _dataPoints = [
      RunningSummaryDatapoint(
        title: "Total distance:",
        value: totalDistance,
        icon: const Icon(Icons.directions_run_rounded),
        unit: "km",
      ),
      RunningSummaryDatapoint(
        title: "Total running time:",
        value: totalDuration,
        icon: const Icon(Icons.timer),
        unit: "min",
      ),
      RunningSummaryDatapoint(
        title: "Average speed:",
        value: avgSpeed,
        icon: const Icon(Icons.speed),
        unit: "km/h",
      ),
    ];

    print("Fake loading start");
    sleep(const Duration(seconds: 1));
    print("Fake loading end");

    setState(() {
      _loading = false;
    });
  }

  double calculateTotalDistance(List<Map<String, dynamic>> data) {
    // Return sum of all distances
    return data
        .map((e) => e['distance'])
        .reduce((value, element) => value + element);
  }

  double calculateTotalDuration(List<Map<String, dynamic>> data) {
    return data
        .map((e) => e['duration'])
        .reduce((value, element) => value + element);
  }
}
