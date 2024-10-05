import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_osm_location_marker/presentation/utility/app_color.dart';
import 'package:flutter_osm_location_marker/presentation/utility/app_urls.dart';
import 'package:flutter_osm_location_marker/state_holder/map_screen_controller.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class MapContent extends StatelessWidget {
  const MapContent({
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
                  child: Icon(
                    Icons.location_pin,
                    color: mapScreenController.giveSearchLocation
                        ? AppColor.backgroundGreenColor
                        : AppColor.backgroundRedColor,
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
