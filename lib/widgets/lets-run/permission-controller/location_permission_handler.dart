import 'package:exercise_tracking_app/widgets/lets-run/permission-controller/dialogs/permission_dialog_widget.dart';
import 'package:exercise_tracking_app/widgets/lets-run/permission-controller/dialogs/permission_dialog_data.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationPermissionHandler extends StatefulWidget {
  const LocationPermissionHandler({super.key});

  @override
  State<LocationPermissionHandler> createState() =>
      _LocationPermissionHandlerState();
}

class _LocationPermissionHandlerState extends State<LocationPermissionHandler> {
  @override
  void initState() {
    super.initState();
    checkPermission(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  void showAlert(BuildContext context, Widget alertDialog) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

  void checkPermission(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();

    await showDialogAccordingly(permission);
  }

  Future<void> showDialogAccordingly(LocationPermission permission) async {
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
