import 'package:get/get.dart';
import 'package:weather_app/src/config/api_end_point.dart';
import 'package:weather_app/src/controllers/location_controller.dart';
import 'package:weather_app/src/helper/global_helper.dart';
import 'package:weather_app/src/models/current_weather.dart';
import 'package:weather_app/src/models/forecast_weather.dart';
import 'package:weather_app/src/services/api_service.dart';
import 'package:weather_app/src/views/home_screen.dart';

class WeatherController extends GetxController with ApiServices {
  final currentWeather = Rx<CurrentWeather?>(null);
  final weatherForecast = RxList<ForecastList?>([]);
  final isCelsius = RxBool(true);

  @override
  void onReady() {
    super.onReady();
    final locationC = Get.put(LocationController());

    getWeather(
        lat: locationC.currentLatLng!.latitude,
        long: locationC.currentLatLng!.longitude,
        unit: isCelsius.value ? 'metric' : 'imperial');
    Get.to(HomeScreen());
  }

  getWeather({required double? lat, required double? long, required String? unit}) async {
    final locationC = Get.put(LocationController());
    await locationC.getAddress(lat: lat, lan: long);
    await getWeatherForecast(lat: lat, lan: long, unit: unit);

    final params = {
      'lat': lat,
      'lon': long,
      'units': unit, //'metric', // celsius
      'appid': ApiEndPoint.apiKey(),
    };
    final res = await getDynamic(path: ApiEndPoint.currentWeatherUrl(), queryParameters: params);

    final currentWeatherData = CurrentWeather.fromJson(res.data as Map<String, dynamic>);

    currentWeather.value = null;
    currentWeather.value = currentWeatherData;
    locationC.areaSearch.value = '';
  }

  getWeatherForecast({double? lat, double? lan, String? unit}) async {
    final params = {
      'lat': lat,
      'lon': lan,
      'units': unit,
      'appid': ApiEndPoint.apiKey(),
    };
    final res = await getDynamic(path: ApiEndPoint.weatherForecastUrl(), queryParameters: params);

    final forecastWeatherData = res.data['list']
        .map((json) => ForecastList.fromJson(json as Map<String, dynamic>))
        .toList()
        .cast<ForecastList>() as List<ForecastList>;

    weatherForecast.clear();

    for (var element in forecastWeatherData) {
      String currentDate = formatDate(date: element.dtTxt!);
      bool isDuplicateDate = false;

      for (var forecast in weatherForecast) {
        if (formatDate(date: forecast!.dtTxt!) == currentDate) {
          isDuplicateDate = true;
          break;
        }
      }

      if (isDuplicateDate) {
        continue;
      }

      weatherForecast.add(element);
    }
  }
}
