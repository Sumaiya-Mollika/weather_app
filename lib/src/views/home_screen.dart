import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/src/config/base.dart';
import 'package:weather_app/src/helper/global_helper.dart';
import 'package:weather_app/src/widgets/forecast_weather_widget.dart';
import 'package:weather_app/src/widgets/weather_widget.dart';

class HomeScreen extends StatelessWidget with Base {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Obx(
            () => Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.shade100))),
              child: TextFormField(
                initialValue: locationC.areaSearch.value,
                style: TextStyle(color: Colors.white),
                onChanged: locationC.areaSearch,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search Area",
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          leading: Obx(
            () => Padding(
              padding: EdgeInsets.only(
                left: 20,
              ),
              child: GestureDetector(
                onTap: () {
                  weatherC.isCelsius.toggle();
                  print(weatherC.isCelsius.value);
                  weatherC.getWeather(
                      lat: locationC.currentLatLng!.latitude,
                      long: locationC.currentLatLng!.longitude,
                      unit: weatherC.isCelsius.value ? 'metric' : 'imperial');
                },
                child: Image.asset(
                  weatherC.isCelsius.value ? 'assets/icons/celsius.png' : 'assets/icons/farenheit.png',
                  height: 20,
                  width: 20,
                ),
              ),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  if (locationC.areaSearch.value.isNotEmpty) locationC.getCoordinate(address: locationC.areaSearch.value);
                },
                icon: Icon(Icons.search)),
            SizedBox(
              width: 20,
            )
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(153, 157, 249, 0.6),
                  Color.fromRGBO(143, 148, 251, 1),
                  Color.fromRGBO(163, 167, 243, 1),
                  Color.fromRGBO(175, 179, 242, 1),
                  Color.fromRGBO(180, 183, 245, 1),
                ],
                // stops: [0.5, 1.0],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Obx(
              () => weatherC.currentWeather.value != null
                  ? Container(
                      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                      alignment: Alignment.topCenter,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                        Color.fromRGBO(143, 148, 251, 1),
                        Color.fromRGBO(143, 148, 251, .6),
                        Color.fromRGBO(150, 155, 252, 0.6),
                      ])),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: '${locationC.area.value} ',
                                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20)),
                                    TextSpan(
                                      text: '${locationC.city.value}',
                                      style: TextStyle(fontSize: 15, color: Colors.grey.shade300),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    weatherC.getWeather(
                                        lat: locationC.currentLatLng!.latitude,
                                        long: locationC.currentLatLng!.longitude,
                                        unit: weatherC.isCelsius.value ? 'metric' : 'imperial');
                                  },
                                  icon: Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.white,
                                    size: 35,
                                  ))
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              formatDate(date: DateTime.now().toString()),
                              style: TextStyle(fontSize: 15, color: Colors.grey.shade300),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              weatherC.currentWeather.value!.weather!.first.icon != null
                                  ? Container(
                                      height: 70,
                                      width: 70,
                                      child: Image.asset('assets/weather/${weatherC.currentWeather.value!.weather!.first.icon}.png'),
                                    )
                                  : Container(),
                              RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: '${weatherC.currentWeather.value!.main!.temp!.toInt()}\u00B0',
                                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25)),
                                    TextSpan(
                                      text: '${weatherC.currentWeather.value!.weather!.first.description}',
                                      style: TextStyle(fontSize: 15, color: Colors.grey.shade300),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            margin: EdgeInsets.symmetric(
                              vertical: 20,
                            ),
                            decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      'assets/icons/sunset.png',
                                      height: 30,
                                      width: 30,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 10),
                                      child: Text('Sunset'),
                                    ),
                                    Text(formatDateTime(date: weatherC.currentWeather.value!.sys!.sunset!.toString())),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      'assets/icons/sunrise.png',
                                      height: 30,
                                      width: 30,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 10),
                                      child: Text('Sunsrise'),
                                    ),
                                    Text(formatDateTime(date: weatherC.currentWeather.value!.sys!.sunrise!.toString())),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              WeatherWidget(
                                iconName: 'windspeed',
                                featureName: 'Windspeed',
                                value: '${weatherC.currentWeather.value!.wind!.speed}km/h',
                              ),
                              WeatherWidget(
                                iconName: 'clouds',
                                featureName: 'Clouds',
                                value: '${weatherC.currentWeather.value!.clouds!.all}%',
                              ),
                              WeatherWidget(
                                iconName: 'humidity',
                                featureName: 'Humidity',
                                value: '${weatherC.currentWeather.value!.main!.humidity}%',
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              WeatherWidget(
                                iconName: 'visibility',
                                featureName: 'Visibility',
                                value: '${weatherC.currentWeather.value!.visibility}km',
                              ),
                              WeatherWidget(
                                iconName: 'atmospheric',
                                featureName: 'Pressure',
                                value: '${weatherC.currentWeather.value!.main!.pressure}hPa',
                              ),
                              WeatherWidget(
                                iconName: 'feels_like',
                                featureName: 'Feels like',
                                value: '${weatherC.currentWeather.value!.main!.feelsLike}\u00B0',
                              ),
                            ],
                          ),
                          ForecastWeatherWidget()
                        ],
                      ),
                    )
                  : Center(
                      child: Text(
                      'No data found',
                      style: TextStyle(color: Color.fromRGBO(80, 88, 229, 0.6), fontSize: 18, fontWeight: FontWeight.w600),
                    )),
            ),
          ),
        ));
  }
}
