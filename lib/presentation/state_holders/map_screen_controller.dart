import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

class MapScreenController {



  static Future<LatLng?> convertAddressToLatLong(String address) async {
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
}
