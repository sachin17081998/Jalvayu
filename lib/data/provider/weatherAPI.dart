import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherAPI {
  String apiKey = '';

  Future<http.Response> fetchWeatherByCityName(String city) async {
    String apiURL =
        'https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${apiKey}&units=metric';

    var response = await http.get(Uri.parse(apiURL));

    return response;
  }

  Future<http.Response> fetchWeatherByGPSLocation(
      double lat, double lon) async {
    String apiURL =
        'https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${lon}&appid=${apiKey}&units=metric';
  
    var response = await http.get(Uri.parse(apiURL));
  
    return response;
  }
}
