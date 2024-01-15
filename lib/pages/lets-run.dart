import 'package:exercise_tracking_app/widgets/lets-run/permission-controller/location_permission_handler.dart';
import 'package:exercise_tracking_app/widgets/lets-run/stopwatch.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LetsRun extends StatefulWidget {
  const LetsRun({super.key});

  @override
  State<LetsRun> createState() => _LetsRunState();
}

class _LetsRunState extends State<LetsRun> {
  final bool _permissionPermanentDenied = false;
  final bool _loadingLocationPermission = false;
  final bool _hasLocationPermission = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Let\'s Run!',
            style: TextStyle(fontSize: 40),
          ),
          centerTitle: true,
        ),
        body: const Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LocationPermissionHandler(),
            VisualStopwatch(),
          ],
        ),
      ),
    );
  }
}
