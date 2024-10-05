import 'package:flutter/material.dart';
import 'package:flutter_osm_location_marker/presentation/screens/map_screen/map_screen.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';

class UserLocationInputScreenFunctions {
  static Future<LatLng?> _convertAddressToLatLong(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        return LatLng(locations.first.latitude, locations.first.longitude);
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  static void onSearchButtonClick({
    required GlobalKey<FormState> formKey,
    required BuildContext context,
    required String? address,
  }) async {
    FocusScope.of(context).unfocus();
    if (formKey.currentState!.validate()) {
      LatLng? latLongByUserInput =
          await _convertAddressToLatLong(address ?? "");

      await _convertAddressToLatLong(address ?? "");

      LatLng userCurrentLatLong = const LatLng(0, 0);

      if (await Permission.location.isDenied) {
        await Permission.location.request();
      }

      if (await Permission.location.isGranted) {
        dynamic res = await Geolocator.getCurrentPosition();
        userCurrentLatLong = LatLng(
          res.latitude,
          res.longitude,
        );
      }

      if (latLongByUserInput != null) {
        if (context.mounted) {
          Get.to(
            () => MapScreen(
              userInputLatLng: latLongByUserInput,
              userCurrentLocation: userCurrentLatLong,
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
