import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class PermissionDialogData {
  final String title;
  final String description;
  final List<Widget> actions;

  PermissionDialogData({
    required this.title,
    required this.description,
    required this.actions,
  });
}

Map<LocationPermission, PermissionDialogData> generateDialogData(
  BuildContext context,
) {
  return {
    LocationPermission.denied: PermissionDialogData(
      title: "We are unable to trace your route!",
      description:
          "In order to measure your running distance, we must have location access!",
      actions: [
        TextButton(
          onPressed: () async {
            Navigator.pop(context);

            LocationPermission permission =
                await Geolocator.requestPermission();

            if (permission == LocationPermission.deniedForever) {
              await Geolocator.openAppSettings();
            }
          },
          child: const Text(
            "Request Permission",
            style: TextStyle(color: Colors.blue),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            "OK",
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ),
    LocationPermission.unableToDetermine: PermissionDialogData(
      title: "Something went wrong!",
      description: "Something went wrong while checking GPS access.",
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            "OK",
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ),
  };
}
