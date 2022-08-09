part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class InitStateEvent extends WeatherEvent{}

class FetchWeatherEvent extends WeatherEvent {
  final String place;
  FetchWeatherEvent({required this.place});
}

class WeatherLoadedEvent extends WeatherEvent {
  final Weather data;
  WeatherLoadedEvent({required this.data});
}

class WeatherErrorEvent extends WeatherEvent {
  final String errorCode;
  final String errorMsg;
  WeatherErrorEvent({required this.errorCode, required this.errorMsg});
}

class GetWeatherByGpsEvent extends WeatherEvent {
  final double latitutde;
  final double longitude;
  GetWeatherByGpsEvent({required this.latitutde, required this.longitude});
}

class WeatherLoadingEvent extends WeatherEvent {}
class WeatherGpsOffEvent extends WeatherEvent{}