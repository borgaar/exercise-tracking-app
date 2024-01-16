import 'package:exercise_tracking_app/utils/location_permission_handling/request_dialog_data.dart';
import 'package:exercise_tracking_app/utils/location_permission_handling/request_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationPermissionHandler {
  void showAlert(BuildContext context, Widget alertDialog) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

  Future<bool> checkAndRequestPermission(
      BuildContext context, bool request) async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied && request) {
      await showRequestLocationDialog(context, permission);
    }

    return LocationPermission.denied != await Geolocator.checkPermission();
  }

  Future<void> showRequestLocationDialog(
      BuildContext context, LocationPermission permission) async {
    final Map<LocationPermission, PermissionDialogData> dialogData =
        generateDialogData(context);

    if (context.mounted) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return PermissionDialog(data: dialogData[permission]!);
        },
      );
    }
  }
}
