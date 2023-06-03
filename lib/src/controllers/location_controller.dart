import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlng/latlng.dart';
import 'package:weather_app/src/controllers/weather_controller.dart';
import 'package:weather_app/src/services/api_service.dart';

class LocationController extends GetxController with ApiServices {
  LatLng? currentLatLng;
  final city = RxString('');
  final area = RxString('');
  final areaSearch = RxString('');

  Future<void> locationListener() async {
    final permissionGranted = await Geolocator.checkPermission();
    if (permissionGranted != LocationPermission.denied) {
      final locations = await Geolocator.getCurrentPosition();

      final latLng = LatLng(
        locations.latitude,
        locations.longitude,
      );
      currentLatLng = latLng;
    }
  }

  /// To get current Location Permission.
  Future<Position> getLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    LocationPermission permissionRequest;
    final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      permission = await _geolocatorPlatform.checkPermission();
      if (permission == LocationPermission.denied) {
        permissionRequest = await _geolocatorPlatform.requestPermission();
        if (permissionRequest == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
        if (permissionRequest == LocationPermission.deniedForever) {
          return Future.error('Location permissions are permanently denied, we cannot request permissions.');
        }
      }
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permissionRequest = await Geolocator.requestPermission();
      if (permissionRequest == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
      if (permissionRequest == LocationPermission.deniedForever) {
        return Future.error('Location permissions are permanently denied, we cannot request permissions.');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  getAddress({double? lat, double? lan}) async {
    List<Placemark> placemark = await placemarkFromCoordinates(lat!, lan!);
    area.value = placemark.first.subLocality!;
    city.value = placemark.first.locality!;
  }

  getCoordinate({String? address, String? identifier}) async {
    final weatherC = Get.put(WeatherController());
    List<Location> locations = await locationFromAddress(address!);
    weatherC.getWeather(
        lat: locations.first.latitude, long: locations.first.longitude, unit: weatherC.isCelsius.value ? 'metric' : 'imperial');
  }
}
