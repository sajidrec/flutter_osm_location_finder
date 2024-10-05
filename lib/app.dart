import 'package:flutter/material.dart';
import 'package:flutter_osm_location_marker/presentation/screens/user_location_input_screen/user_location_input_screen.dart';
import 'package:flutter_osm_location_marker/presentation/utility/app_color.dart';

class OSMLocationMarkerApp extends StatelessWidget {
  const OSMLocationMarkerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const UserLocationInputScreen(),
      theme: ThemeData(
        scaffoldBackgroundColor: AppColor.backgroundWhiteColor,
      ),
    );
  }
}
