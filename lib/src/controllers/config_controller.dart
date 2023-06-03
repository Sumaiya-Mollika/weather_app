import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/src/config/base.dart';

class ConfigController extends GetxController with Base {
  Future<void> initAppConfig() async {
    WidgetsFlutterBinding.ensureInitialized();
    await locationC.getLocationPermission();

    await locationC.locationListener();
  }
}
