import 'package:exercise_tracking_app/widgets/lets-run/map-widget/constants.dart';
import 'package:exercise_tracking_app/widgets/lets-run/map-widget/updating_position_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class TheMap extends StatefulWidget {
  bool following;
  MapController mapController;
  Function executeOnMapMove;
  double? previousZoom;

  TheMap({
    super.key,
    required this.following,
    required this.mapController,
    required this.executeOnMapMove,
  });

  @override
  State<TheMap> createState() => _TheMapState();
}

class _TheMapState extends State<TheMap> {
  Position? _location;
  double _previousZoom = 0;

  @override
  void initState() {
    super.initState();
    updateLocation();
  }

  @override
  Widget build(BuildContext context) {
    return _location == null
        ? const Center(child: UpdatingPosition())
        : FlutterMap(
            mapController: widget.mapController,
            options: MapOptions(
              initialCenter: convertPostoLatLng(_location!),
              initialZoom: zoomOnMapInitialization,
              minZoom: 10,
              maxZoom: 20,
              onMapEvent: (mapEvent) {
                if ((mapEvent.source == MapEventSource.onDrag || mapEvent.source == MapEventSource.onMultiFinger) &&
                    widget.following) {
                  widget.executeOnMapMove();
                }
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),
              CurrentLocationLayer(
                followOnLocationUpdate: widget.following
                    ? FollowOnLocationUpdate.always
                    : FollowOnLocationUpdate.never,
              ),
            ],
          );
  }

  Future<void> updateLocation() async {
    _location = await Geolocator.getCurrentPosition();

    setState(() {});
  }

  LatLng convertPostoLatLng(Position pos) {
    return LatLng(pos.latitude, pos.longitude);
  }
}
