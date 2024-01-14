import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Text("Exercise App",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
    );
  }
}
