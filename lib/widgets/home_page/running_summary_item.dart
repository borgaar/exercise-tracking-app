import 'package:exercise_tracking_app/widgets/home_page/running_summary_datapoint.dart.dart';
import 'package:flutter/material.dart';

class RunningSummaryItem extends StatelessWidget {
  final RunningSummaryDatapoint data;

  const RunningSummaryItem({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        data.icon,
        Text(data.title),
        Text("${data.value} ${data.unit}"),
      ],
    );
  }
}
