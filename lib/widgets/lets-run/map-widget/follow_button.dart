import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  final bool gpsFollowing;
  final Function executeOnPressed;

  const FollowButton({
    super.key,
    required this.gpsFollowing,
    required this.executeOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: FloatingActionButton(
        backgroundColor: gpsFollowing ? Colors.red : Colors.grey,
        foregroundColor: Colors.black,
        onPressed: () {
          executeOnPressed();
        },
        child: gpsFollowing
            ? const Icon(Icons.gps_fixed)
            : const Icon(Icons.gps_not_fixed),
      ),
    );
  }
}
