class ApiEndPoint {
  static String currentWeatherUrl() {
    return 'https://api.openweathermap.org/data/2.5/weather';
  }

  static String weatherForecastUrl() {
    return 'https://api.openweathermap.org/data/2.5/forecast';
  }

  static String apiKey() {
    return 'c006627b812ee7506101015423a98256';
  }

  //api.openweathermap.org/data/2.5/forecast?lat={lat}&lon={lon}&appid={API key}
}
