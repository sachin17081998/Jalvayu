part of 'weather_bloc.dart';

//we need equatable because we want to check the object wether ther are same between previous
// and next state. if we do not do so then our UI will not rebuild
@immutable
abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class InitialState extends WeatherState {
  late Weather initialWeatherData;
  // =const Weather(place: 'Perfect Day',
  // main: 'Clear',
  //  description:'Clear Sky',
  //   icon: '01d',
  //   temperatur: '32',
  //    humidity: '50',
  //    windspeed: '15',
  //    dateTime: 1560350645,
  //    sunrise: 1560343627,
  //     sunset: 1560396563,
  //     pressure: 1000);

  InitialState() {
    initialWeatherData = const Weather(
        place: 'Perfect Day',
        main: 'Clear',
        description: 'Clear Sky',
        icon: '01d',
        temperatur: '32',
        humidity: '50',
        windspeed: '15',
        dateTime: 1560350645,
        sunrise: 1560343627,
        sunset: 1560396563,
        pressure: 1000);
  }
}

class WeatherLoadingState extends WeatherState {}
class WeatherGpsOffState extends WeatherState {}
class WeatherLoadedState extends WeatherState {
  final Weather weatherData;
  const WeatherLoadedState({required this.weatherData});
  @override
  List<Object> get props => [weatherData];
}

class WeatherErrorState extends WeatherState {
  final String errorCode;
  final String errorMsg;
  const WeatherErrorState({required this.errorCode, required this.errorMsg});
}
