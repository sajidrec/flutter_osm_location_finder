import 'package:flutter/material.dart';
import 'package:flutter_osm_location_marker/presentation/screens/map_screen/map_screen.dart';
import 'package:flutter_osm_location_marker/presentation/state_holders/map_screen_controller.dart';
import 'package:latlong2/latlong.dart';

class UserLocationInputScreenFunctions {
  static void onSearchButtonClick({
    required GlobalKey<FormState> formKey,
    required BuildContext context,
    required String? address,
  }) async {
    FocusScope.of(context).unfocus();
    if (formKey.currentState!.validate()) {
      LatLng? latLongByUserInput =
          await MapScreenController.convertAddressToLatLong(address ?? "");

      if (latLongByUserInput != null) {
        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MapScreen(
                userInputLatLng: latLongByUserInput,
              ),
            ),
          );
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "No location found",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
          );
        }
      }
    }
  }
}
