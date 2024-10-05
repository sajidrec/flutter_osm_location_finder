import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_osm_location_marker/presentation/utility/app_urls.dart';
import 'package:flutter_osm_location_marker/state_holder/map_screen_controller.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_osm_location_marker/presentation/utility/app_color.dart';

class MapScreen extends StatelessWidget {
  final LatLng userInputLatLng;

  const MapScreen({
    super.key,
    required this.userInputLatLng,
  });

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
            _mapContent(),
            _buildMapToggleButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildMapToggleButton() {
    return Positioned(
      top: 20,
      right: 20,
      child: GetBuilder<MapScreenController>(
        builder: (mapScreenController) {
          return FloatingActionButton(
            backgroundColor: mapScreenController.isNormalMap
                ? Colors.blueAccent.withOpacity(
                    0.75,
                  )
                : Colors.white.withOpacity(0.9),
            onPressed: () {
              mapScreenController.switchMapVersion();
            },
            child: Icon(
              Icons.layers,
              color: mapScreenController.isNormalMap
                  ? Colors.white.withOpacity(0.9)
                  : Colors.blueAccent.withOpacity(0.75),
            ),
          );
        },
      ),
    );
  }

  Widget _mapContent() {
    return FlutterMap(
      options: MapOptions(
        initialCenter: userInputLatLng,
        initialZoom: 16,
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.all,
        ),
      ),
      children: [
        _osmTileLayer,
        MarkerLayer(
          markers: [
            Marker(
              point: userInputLatLng,
              child: const Icon(
                Icons.location_pin,
                color: Colors.red,
                size: 50,
              ),
            ),
          ],
        ),
      ],
    );
  }

  GetBuilder<MapScreenController> get _osmTileLayer =>
      GetBuilder<MapScreenController>(
        builder: (mapScreenController) {
          return TileLayer(
            urlTemplate: mapScreenController.isNormalMap
                ? AppUrls.osmMapUrlNormal // Normal OSM
                : AppUrls.osmMapUrlSecondType,
            // Hot OSM map
            userAgentPackageName: "dev.fleaflet.flutter_map.example",
          );
        },
      );
}
