import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_osm_location_marker/presentation/screens/map_screen/widgets/location_toggle_button.dart';
import 'package:flutter_osm_location_marker/presentation/screens/map_screen/widgets/map_content.dart';
import 'package:flutter_osm_location_marker/presentation/screens/map_screen/widgets/map_type_toggle_button.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_osm_location_marker/presentation/utility/app_color.dart';

class MapScreen extends StatelessWidget {
  final LatLng userInputLatLng;
  final LatLng userCurrentLocation;

  MapScreen({
    super.key,
    required this.userInputLatLng,
    required this.userCurrentLocation,
  });

  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.backgroundWhiteColor,
          title: const Text("Map"),
        ),
        body: Stack(
          children: [
            MapContent(
              mapController: _mapController,
              userInputLatLng: userInputLatLng,
              userCurrentLocation: userCurrentLocation,
            ),
            const MapTypeToggleButton(),
            Locationtogglebutton(
              mapController: _mapController,
              userInputLatLng: userInputLatLng,
              userCurrentLocation: userCurrentLocation,
            ),
          ],
        ),
      ),
    );
  }
}
