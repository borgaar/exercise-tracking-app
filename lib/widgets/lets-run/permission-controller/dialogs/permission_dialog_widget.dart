import 'package:exercise_tracking_app/widgets/lets-run/permission-controller/dialogs/permission_dialog_data.dart';
import 'package:flutter/material.dart';

class PermissionDialog extends StatelessWidget {
  final PermissionDialogData data;

  const PermissionDialog({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(data.title),
      content: Text(
        data.description,
      ),
      actions: data.actions,
    );
  }
}
