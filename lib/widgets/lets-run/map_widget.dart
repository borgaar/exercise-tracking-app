import 'package:exercise_tracking_app/widgets/lets-run/map-widget/follow_button.dart';
import 'package:exercise_tracking_app/widgets/lets-run/map-widget/map.dart';
import 'package:exercise_tracking_app/widgets/lets-run/map-widget/map_zoom_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';

class TracingMap2 extends StatefulWidget {
  const TracingMap2({super.key});

  @override
  State<TracingMap2> createState() => _TracingMap2State();
}

class _TracingMap2State extends State<TracingMap2>
    with TickerProviderStateMixin {
  late final AnimatedMapController _animatedMapController =
      AnimatedMapController(vsync: this);
  bool _following = true;
  bool _showZoomSlider = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Center(
            child: TheMap(
              following: _following,
              mapController: _animatedMapController.mapController,
              executeOnMapMove: doOnMapMove,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 20),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back),
            ),
          ),
          Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 40.0, horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FollowButton(
                    gpsFollowing: _following,
                    executeOnPressed: toggleFollowing,
                  ),
                  SizedBox(
                    height: 30,
                    child: _showZoomSlider
                        ? MapSlider(
                            visualSliderValue: getCurrentZoomLevel(),
                            executeOnValueChange: changeZoom,
                          )
                        : const SizedBox(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  double getCurrentZoomLevel() {
    try {
      return _animatedMapController.mapController.camera.zoom;
    } catch (e) {
      return 15;
    }
  }

  void toggleFollowing() async {
    _following = !_following;
    _showZoomSlider = !_showZoomSlider;

    if (_following) {
      _animatedMapController.animatedRotateTo(0);
    }
    setState(() {});
  }

  void doOnMapMove() {
    if (_following) {
      setState(() {
        _showZoomSlider = false;
        _following = false;
      });
    }
  }

  void changeZoom(double newZoom) {
    _animatedMapController.mapController
        .move(_animatedMapController.mapController.camera.center, newZoom);
  }
}
