import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bg_location_test/location_service_repository.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  MapController mapController = MapController();

  LatLng pos = new LatLng(10.22898, 76.2653);
  List<LatLng> markers = [];

  @override
  void initState() {
    super.initState();

    LocationServiceRepository().controller.stream.listen((event) {
      markers.add(event);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    markers.add(pos);
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            controller: mapController,
            allowPanning: false,
            interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
            center: pos,
            zoom: 13.0,
            plugins: [],
            onTap: (_) => null,
          ),
          layers: [
            TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c']),
            PolylineLayerOptions(
              polylineCulling: true,
              polylines: [
                Polyline(
                  points: markers,
                  color: Colors.black,
                  strokeWidth: 4.0,
                  gradientColors: [
                    Colors.deepPurple,
                    Colors.red,
                  ],
                )
              ],
            )
          ],
        ),
        Container(
          color: Colors.green,
          child: Text('${markers.length}'),
          padding: EdgeInsets.all(10),
        ),
      ],
    );
  }
}
