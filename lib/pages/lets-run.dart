import 'package:exercise_tracking_app/widgets/lets-run/stopwatch.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LetsRun extends StatefulWidget {
  const LetsRun({super.key});

  @override
  State<LetsRun> createState() => _LetsRunState();
}

class _LetsRunState extends State<LetsRun> {
  bool _permissionPermanentDenied = false;
  bool _loadingLocationPermission = false;
  bool _hasLocationPermission = false;

  @override
  void initState() {
    super.initState();
    checkAndRequestLocationPermission();
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
            VisualStopwatch(),
          ],
        ),
      ),
    );
  }

  void checkAndRequestLocationPermission() async {
    setState(() {
      _loadingLocationPermission = true;
    });

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _permissionPermanentDenied = true;
        _hasLocationPermission = false;
        _loadingLocationPermission = false;
      });
      return;
    } else if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _permissionPermanentDenied = true;
          _hasLocationPermission = false;
          _loadingLocationPermission = false;
          return;
        });
      } else if (permission == LocationPermission.denied) {
        setState(() {
          _permissionPermanentDenied = false;
          _hasLocationPermission = false;
          _loadingLocationPermission = false;
          return;
        });
      }
    }

    setState(() {
      _permissionPermanentDenied = false;
      _hasLocationPermission = true;
      _loadingLocationPermission = false;
    });
  }
}
