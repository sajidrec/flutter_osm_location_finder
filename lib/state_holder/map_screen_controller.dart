import 'package:get/get.dart';

class MapScreenController extends GetxController {
  bool _isNormalMap = true;

  bool get isNormalMap => _isNormalMap;

  void switchMapVersion() {
    _isNormalMap = !_isNormalMap;
    update();
  }
}
