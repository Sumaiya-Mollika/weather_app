import 'package:get/get.dart';
import 'package:weather_app/src/controllers/location_controller.dart';
import 'package:weather_app/src/controllers/weather_controller.dart';

class Base {
  final weatherC = Get.put(WeatherController());
  final locationC = Get.put(LocationController());
}
