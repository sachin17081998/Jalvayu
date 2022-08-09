import 'dart:convert';

import 'package:jalavaayu/data/model/weather_modl.dart';
import 'package:jalavaayu/data/provider/weatherAPI.dart';

class WeatherRepository {
  final WeatherAPI _weatherAPI = WeatherAPI();

  Future<Weather> getWeatherByLocationName(String name) async {
    try {
      var response = await _weatherAPI.fetchWeatherByCityName(name);
     
      if (response.statusCode == 200) {
        return Weather.fromJson(jsonDecode(response.body));
      }
      throw (jsonDecode(response.body));
    } catch (e) {
    
      rethrow;
    }
  }
   Future<Weather> getWeatherByGps(double lat,double lon) async {
    try {
      var response = await _weatherAPI.fetchWeatherByGPSLocation(lat, lon);
     
      if (response.statusCode == 200) {
        return Weather.fromJson(jsonDecode(response.body));
      }
      throw (jsonDecode(response.body));
    } catch (e) {
     
      rethrow;
    }
  }
}
