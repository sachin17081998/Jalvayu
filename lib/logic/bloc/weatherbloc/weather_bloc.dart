import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jalavaayu/data/model/weather_modl.dart';
import 'package:jalavaayu/logic/bloc/Gpsbloc/gps_bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/repository/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(InitialState()) {
   
    on<FetchWeatherEvent>((event, emit) {
      add(WeatherLoadingEvent());
      WeatherRepository().getWeatherByLocationName(event.place).then((value) {
        add(WeatherLoadedEvent(data: value));
      }).catchError((e) {
        add(WeatherErrorEvent(
            errorCode: e['cod'].toString(), errorMsg: e['message'].toString()));
      });
    });
    on<WeatherLoadedEvent>((event, emit) {
      emit(WeatherLoadedState(weatherData: event.data));
    });
    on<WeatherGpsOffEvent>((event, emit) {
      emit(WeatherGpsOffState());
    });
  
    on<GetWeatherByGpsEvent>(((event, emit) {
      add(WeatherLoadingEvent());
      WeatherRepository()
          .getWeatherByGps(event.latitutde, event.longitude)
          .then((value) {
       
        add(WeatherLoadedEvent(data: value));
      }).catchError((e) {
        add(WeatherErrorEvent(
            errorCode: e['cod'].toString(), errorMsg: e['message'].toString()));
      });
    }));
    on<WeatherErrorEvent>((event, emit) {
      emit(WeatherErrorState(
          errorCode: event.errorCode, errorMsg: event.errorMsg));
    });
    on<WeatherLoadingEvent>((event, emit) => emit(WeatherLoadingState()));
  }
}
