import 'package:exercise_tracking_app/constants.dart';
import 'package:exercise_tracking_app/utils/location_permission_handling/location_permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class TracingMap extends StatefulWidget {
  final BuildContext context;

  const TracingMap({super.key, required this.context});

  @override
  State<TracingMap> createState() => _TracingMapState();
}

class _TracingMapState extends State<TracingMap> {
  final MapController mapController = MapController();
  Position? _location;
  bool _loadingPosition = true;
  String? mapURL;

  @override
  void initState() {
    super.initState();
    updateMap();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        !_loadingPosition
            ? SizedBox(
                width: 300,
                height: 500,
                child: FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    initialCenter:
                        LatLng(_location!.latitude, _location!.longitude),
                    initialZoom: mapZoom,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    ),
                    CurrentLocationLayer(),
                  ],
                ),
              )
            : const Text("GETTING POSITION..."),
        const SizedBox(
          height: 20,
        ),
        FloatingActionButton(
          onPressed: () {
            updateMap();
          },
          child: const Icon(Icons.location_pin),
        ),
      ],
    );
  }

  void updateMap() async {
    setState(() {
      _loadingPosition = true;
    });

    _location = await Geolocator.getCurrentPosition();

    print(_location);

    setState(() {
      _loadingPosition = false;
    });
  }
}
