import 'package:flutter_osm_location_marker/presentation/screens/map_screen/map_screen.dart';
import 'package:flutter_osm_location_marker/presentation/utility/app_color.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';

class UserLocationInputScreenController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  Future<LatLng?> _convertAddressToLatLong(String address) async {
    _inProgress = true;
    update();
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        _inProgress = false;
        update();
        return LatLng(locations.first.latitude, locations.first.longitude);
      }
    } catch (e) {
      _inProgress = false;
      update();
      return null;
    }
    _inProgress = false;
    update();
    return null;
  }

  Future<void> onSearchButtonClick({
    required String? address,
  }) async {
    LatLng? latLongByUserInput = await _convertAddressToLatLong(address ?? "");

    await _convertAddressToLatLong(address ?? "");

    LatLng userCurrentLatLong = const LatLng(0, 0);

    if (await Permission.location.isDenied) {
      await Permission.location.request();
    }

    if (await Permission.location.isGranted) {
      _inProgress = true;
      update();
      dynamic res = await Geolocator.getCurrentPosition();
      userCurrentLatLong = LatLng(
        res.latitude,
        res.longitude,
      );
      _inProgress = false;
      update();
    }

    if (latLongByUserInput != null) {
      Get.to(
        () => MapScreen(
          userInputLatLng: latLongByUserInput,
          userCurrentLocation: userCurrentLatLong,
        ),
      );
    } else {
      Get.snackbar(
        "Sorry",
        "Location not found",
        backgroundColor: AppColor.backgroundRedColor,
        colorText: AppColor.backgroundWhiteColor,
      );
    }
  }
}
