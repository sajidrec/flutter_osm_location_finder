import 'package:flutter/material.dart';
import 'package:flutter_osm_location_marker/controller_binder.dart';
import 'package:flutter_osm_location_marker/presentation/screens/user_location_input_screen/user_location_input_screen.dart';
import 'package:flutter_osm_location_marker/presentation/utility/app_color.dart';
import 'package:get/get.dart';

class OSMLocationMarkerApp extends StatelessWidget {
  const OSMLocationMarkerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: ControllerBinder(),
      home: const UserLocationInputScreen(),
      theme: ThemeData(
        scaffoldBackgroundColor: AppColor.backgroundWhiteColor,
      ),
    );
  }
}
