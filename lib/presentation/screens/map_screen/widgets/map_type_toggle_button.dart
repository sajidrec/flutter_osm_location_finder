import 'package:flutter/material.dart';
import 'package:flutter_osm_location_marker/state_holder/map_screen_controller.dart';
import 'package:get/get.dart';

class MapTypeToggleButton extends StatelessWidget {
  const MapTypeToggleButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
}
