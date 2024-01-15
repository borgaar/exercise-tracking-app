import 'package:flutter/material.dart';

class RunningSummaryDatapoint {
  final String title;
  final double value;
  final Icon icon;
  final String unit;

  RunningSummaryDatapoint({
    required this.title,
    required this.value,
    required this.icon,
    required this.unit,
  });
}
