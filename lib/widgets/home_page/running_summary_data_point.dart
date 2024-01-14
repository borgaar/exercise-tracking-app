import 'package:flutter/material.dart';

class RunningSummaryDataPoint extends StatelessWidget {
  final Icon icon;
  final String title;
  final double value;
  final String unit;
  String? subtite;

  RunningSummaryDataPoint(
      {super.key,
      required this.icon,
      required this.title,
      required this.value,
      required this.unit,
      this.subtite});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      icon,
      Text(title),
      Text("$value $unit"),
    ]);
  }
}
