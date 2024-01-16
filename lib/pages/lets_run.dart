import 'package:exercise_tracking_app/utils/location_permission_handling/location_permission_handler.dart';
import 'package:exercise_tracking_app/widgets/lets-run/map.dart';
import 'package:exercise_tracking_app/widgets/lets-run/stopwatch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';

class LetsRun extends StatefulWidget {
  final LocationPermissionHandler locationPermissionHandler =
      LocationPermissionHandler();

  LetsRun({super.key});

  @override
  State<LetsRun> createState() => _LetsRunState();
}

class _LetsRunState extends State<LetsRun> {
  bool _hasLocationPermission = false;

  @override
  void initState() {
    super.initState();
    updateHasLocationPermissionState();
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _hasLocationPermission
                  ? TracingMap(
                      context: context,
                    )
                  : Column(
                      children: [
                        const Text("NO GPS ACCESS"),
                        TextButton(
                          onPressed: () async {
                            _hasLocationPermission =
                                LocationPermission.denied !=
                                    await Geolocator.checkPermission();
                            setState(() {});
                          },
                          child: const Text("I have given permission"),
                        ),
                      ],
                    ),
              const SizedBox(
                height: 30,
              ),
              const VisualStopwatch(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateHasLocationPermissionState() async {
    _hasLocationPermission =
        await widget.locationPermissionHandler.checkPermission(context, true);

    setState(() {});
  }
}
