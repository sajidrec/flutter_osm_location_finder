import 'package:flutter/material.dart';
import 'package:flutter_osm_location_marker/presentation/screens/map_screen/map_screen.dart';

class UserLocationInputScreenFunctions {
  static void onSearchButtonClick({
    required GlobalKey<FormState> formKey,
    required BuildContext context,
  }) {
    FocusScope.of(context).unfocus();
    if (formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MapScreen(),
        ),
      );
    }
  }
}
