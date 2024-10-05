import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_osm_location_marker/presentation/utility/app_urls.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_osm_location_marker/presentation/utility/app_color.dart';

class MapScreen extends StatefulWidget {
  final LatLng userInputLatLng;

  const MapScreen({
    super.key,
    required this.userInputLatLng,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool _isNormalMap = true; // Flag to track map mode

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
      child: FloatingActionButton(
        backgroundColor: _isNormalMap
            ? Colors.blueAccent.withOpacity(
                0.75,
              )
            : Colors.white.withOpacity(0.9),
        onPressed: () {
          _isNormalMap = !_isNormalMap;
          setState(() {});
        },
        child: Icon(
          Icons.layers,
          color: _isNormalMap
              ? Colors.white.withOpacity(0.9)
              : Colors.blueAccent.withOpacity(0.75),
        ),
      ),
    );
  }

  Widget _mapContent() {
    return FlutterMap(
      options: MapOptions(
        initialCenter: widget.userInputLatLng,
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
              point: widget.userInputLatLng,
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

  TileLayer get _osmTileLayer => TileLayer(
        urlTemplate: _isNormalMap
            ? AppUrls.osmMapUrlNormal // Normal OSM
            : AppUrls.osmMapUrlSecondType,
        // Hot OSM map
        userAgentPackageName: "dev.fleaflet.flutter_map.example",
      );
}
