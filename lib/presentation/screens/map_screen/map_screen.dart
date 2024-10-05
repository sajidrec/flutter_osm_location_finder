import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_osm_location_marker/presentation/utility/app_urls.dart';
import 'package:flutter_osm_location_marker/state_holder/map_screen_controller.dart';
import 'package:get/get.dart';
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
            _mapContent(),
            _buildMapTypeToggleButton(),
            _buildLocationToggleButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildMapTypeToggleButton() {
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

  Widget _buildLocationToggleButton() {
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

  Widget _mapContent() {
    return GetBuilder<MapScreenController>(
      builder: (mapScreenController) {
        return FlutterMap(
          mapController: _mapController,
          options: MapOptions(
            initialCenter: mapScreenController.giveSearchLocation
                ? userInputLatLng
                : userCurrentLocation,
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
                  point: mapScreenController.giveSearchLocation
                      ? userInputLatLng
                      : userCurrentLocation,
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
      },
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
