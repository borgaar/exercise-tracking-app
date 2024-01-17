import 'package:flutter/material.dart';

class MapSlider extends StatefulWidget {
  Function executeOnValueChange;
  double visualSliderValue;
  double previousActualSliderValue = 0;

  MapSlider({
    super.key,
    required this.visualSliderValue,
    required this.executeOnValueChange,
  });

  @override
  State<MapSlider> createState() => _MapSliderState();
}

class _MapSliderState extends State<MapSlider> {
  @override
  Widget build(BuildContext context) {
    return Slider(
      inactiveColor: Colors.grey,
      thumbColor: Colors.red,
      activeColor: Colors.red,
      label: '${((widget.visualSliderValue - 10) / 0.1).toStringAsFixed(0)}%',
      value: widget.visualSliderValue,
      min: 10,
      max: 20,
      divisions: 10,
      onChanged: (actualSliderValue) {
        widget.executeOnValueChange(actualSliderValue);
        widget.visualSliderValue = actualSliderValue;
        widget.previousActualSliderValue = actualSliderValue;
        setState(() {});
      },
    );
  }
}
