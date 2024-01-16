import 'package:flutter/material.dart';

class VisualStopwatch extends StatefulWidget {
  const VisualStopwatch({super.key});

  @override
  State<VisualStopwatch> createState() => _VisualStopwatchState();
}

class _VisualStopwatchState extends State<VisualStopwatch> {
  final Stopwatch _stopwatch = Stopwatch();
  String elapsedPretty = '00:00:00.0';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: TextButton(
        onPressed: () {
          if (_stopwatch.isRunning) {
            _stopwatch.stop();
          } else {
            _stopwatch.start();
            updateVisualStopWatch();
          }
        },
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(40)),
            color: Colors.blue,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.play_arrow_rounded,
                size: 60,
                color: Colors.white,
              ),
              Text(
                elapsedPretty,
                style: const TextStyle(
                  fontSize: 70,
                  color: Colors.white,
                  fontFamily: 'Digital',
                  letterSpacing: 5,
                ),
              ),
              IconButton(
                onPressed: () {
                  _stopwatch.reset();
                  setState(() {
                    elapsedPretty = '00:00:00.0';
                  });
                },
                icon: const Icon(
                  Icons.restart_alt_outlined,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateVisualStopWatch() async {
    while (_stopwatch.isRunning) {
      await Future.delayed(const Duration(milliseconds: 100));

      int firstDecimal = (_stopwatch.elapsed.inMilliseconds / 100).truncate() -
          (_stopwatch.elapsed.inSeconds * 10);
      int seconds =
          _stopwatch.elapsed.inSeconds - _stopwatch.elapsed.inMinutes * 60;
      int minutes =
          _stopwatch.elapsed.inMinutes - _stopwatch.elapsed.inHours * 60;
      int hours = _stopwatch.elapsed.inHours;

      String secondsString = seconds < 10 ? "0$seconds" : "$seconds";
      String minutesString = minutes < 10 ? "0$minutes" : "$minutes";
      String hoursString = hours < 10 ? "0$hours" : "$hours";

      setState(() {
        elapsedPretty =
            "$hoursString:$minutesString:$secondsString.$firstDecimal";
      });
    }
  }

  int getElapsedMilliseconds() {
    return _stopwatch.elapsed.inMicroseconds;
  }
}
