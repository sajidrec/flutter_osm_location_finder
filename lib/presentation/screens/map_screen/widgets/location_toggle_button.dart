import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_osm_location_marker/state_holder/map_screen_controller.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class Locationtogglebutton extends StatelessWidget {
  const Locationtogglebutton({
    super.key,
    required MapController mapController,
    required this.userInputLatLng,
    required this.userCurrentLocation,
  }) : _mapController = mapController;

  final MapController _mapController;
  final LatLng userInputLatLng;
  final LatLng userCurrentLocation;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 90,
      right: 20,
      child: GetBuilder<MapScreenController>(
        builder: (mapScreenController) {
          return FloatingActionButton(
            backgroundColor: mapScreenController.giveSearchLocation
                ? Colors.blueAccent.withOpacity(
                    0.75,
                  )
                : Colors.white.withOpacity(0.9),
            onPressed: () {
              mapScreenController.switchLocation();
              _mapController.move(
                  mapScreenController.giveSearchLocation
                      ? userInputLatLng
                      : userCurrentLocation,
                  16);
            },
            child: Icon(
              Icons.person,
              color: mapScreenController.giveSearchLocation
                  ? Colors.white.withOpacity(0.9)
                  : Colors.blueAccent.withOpacity(0.75),
            ),
          );
        },
      ),
    );
  }
}
