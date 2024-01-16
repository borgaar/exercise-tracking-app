import 'package:exercise_tracking_app/pages/lets_run.dart';
import 'package:exercise_tracking_app/widgets/home_page/running_summary.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(fontSize: 40),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Overview",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            const RunningSummary(),
            const SizedBox(height: 80),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LetsRun()),
                );
              },
              child: const Text("Let's Run!"),
            ),
          ],
        ),
      ),
    );
  }
}
