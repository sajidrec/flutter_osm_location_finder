import 'package:flutter_osm_location_marker/state_holder/map_screen_controller.dart';
import 'package:flutter_osm_location_marker/state_holder/user_location_input_screen_controller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(MapScreenController());
    Get.put(UserLocationInputScreenController());
  }
}
