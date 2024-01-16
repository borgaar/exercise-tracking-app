import 'dart:async';
import 'dart:io';

import 'package:exercise_tracking_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class TracingMap extends StatefulWidget {
  final BuildContext context;

  const TracingMap({
    super.key,
    required this.context,
  });

  @override
  State<TracingMap> createState() => _TracingMapState();
}

class _TracingMapState extends State<TracingMap> with TickerProviderStateMixin {
  late final _animatedMapController = AnimatedMapController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeInOut,
  );
  Position? _location;
  bool _loadingPosition = false;
  bool _trackingPosition = true;
  final double _mapZoom = 15;
  bool _resetting = false;

  @override
  void initState() {
    super.initState();
    getInitialPosition();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          !_loadingPosition
              ? FlutterMap(
                  mapController: _animatedMapController.mapController,
                  options: MapOptions(
                    onMapEvent: (value) {
                      if (!_resetting) {
                        _trackingPosition = false;
                        if (value.toString() ==
                            "Instance of 'MapEventMoveStart'") {
                          setState(() {});
                        }
                      }
                    },
                    initialCenter:
                        LatLng(_location!.latitude, _location!.longitude),
                    initialZoom: _mapZoom,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    ),
                    CurrentLocationLayer(
                      followOnLocationUpdate: _trackingPosition
                          ? FollowOnLocationUpdate.always
                          : FollowOnLocationUpdate.never,
                    ),
                  ],
                )
              : const Center(child: Text("GETTING POSITION...")),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: FloatingActionButton(
                    onPressed: () async {
                      setState(() {
                        _resetting = true;
                      });

                      await _animatedMapController.animateTo(
                        dest: posToLatLng(_location),
                        zoom: _mapZoom,
                        rotation: 0,
                      );


                      setState(() {
                        _trackingPosition = true;
                        _resetting = false;
                      });
                    },
                    child: Icon(
                      _trackingPosition ? Icons.gps_fixed : Icons.gps_not_fixed,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void getInitialPosition() async {
    setState(() {
      _loadingPosition = true;
    });

    _location = await Geolocator.getCurrentPosition();

    setState(() {
      _loadingPosition = false;
    });
  }

  LatLng posToLatLng(Position? pos) {
    return LatLng(pos!.latitude, pos.longitude);
  }
}
