import 'package:get/get.dart';

class MapScreenController extends GetxController {
  bool _isNormalMap = true;
  bool _giveSearchLocation = true;

  bool get giveSearchLocation => _giveSearchLocation;

  bool get isNormalMap => _isNormalMap;

  void switchMapVersion() {
    _isNormalMap = !_isNormalMap;
    update();
  }

  void switchLocation() {
    _giveSearchLocation = !_giveSearchLocation;
    update();
  }
}
