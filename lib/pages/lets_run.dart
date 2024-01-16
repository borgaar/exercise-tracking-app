import 'package:exercise_tracking_app/utils/location_permission_handling/location_permission_handler.dart';
import 'package:exercise_tracking_app/widgets/lets-run/map.dart';
import 'package:exercise_tracking_app/widgets/lets-run/stopwatch.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LetsRun extends StatefulWidget {
  final LocationPermissionHandler locationPermissionHandler =
      LocationPermissionHandler();

  LetsRun({super.key});

  @override
  State<LetsRun> createState() => _LetsRunState();
}

class _LetsRunState extends State<LetsRun> with WidgetsBindingObserver {
  bool _hasLocationPermission = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    updateHasLocationPermissionState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          _hasLocationPermission
              ? TracingMap(
                  context: context,
                )
              : const Text("NO LOCATION ACCESS"),
          const SizedBox(
            height: 30,
          ),
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                VisualStopwatch(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> updateHasLocationPermissionState() async {
    _hasLocationPermission = await widget.locationPermissionHandler
        .checkAndRequestPermission(context, true);

    print(_hasLocationPermission);

    setState(() {});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      _hasLocationPermission =
          await Geolocator.checkPermission() != LocationPermission.denied;
      setState(() {});
    }
  }
}
