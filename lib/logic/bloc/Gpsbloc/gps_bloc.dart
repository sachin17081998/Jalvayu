import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

// import 'package:location/location.dart';
part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  GpsBloc() : super(GpsInitial()) {
    on<FetchGpsEvent>((event, emit) {
        add(GpsLoadingEvent());
      getGpsLocation().then((value) {
      
        add(GpsAcquiredEvent(
            latitude: value.latitude,
            longitude: value.longitude,
            locationPermission: true));
      }).catchError((e) {
        if (e == 'Denied') {
          add(GpsAccessDeniedEvent());
        } else if (e == 'Location Off') {
          add(GpsOffEvent());
        } else {
          add(GpsErrorEvent(msg: e.toString()));
        }
      });
    });

    on<GpsOffEvent>((event, emit) {
      emit(GpsOffState());
    });
    on<GpsAcquiredEvent>((event, emit) {
      emit(GpsWeatherFetchedState(
          latitude: event.latitude,
          longitude: event.longitude,
          locationPermission: event.locationPermission));
    });
    on<GpsErrorEvent>((event, emit) {
      if (event.msg == 'Location Off') {
        emit(GpsOffState());
      }
      emit(GpsErrorState(msg: event.msg));
    });
    on<GpsLoadingEvent>((event, emit) {
      emit(GpsLoadingState());
    });
    on<GpsAccessDeniedEvent>((event, emit) {
      emit(GpsAccessDenied());
    });

    on<OpenLocationSettingsEvent>((event, emit) {
      openSettings();
      emit(OpenLocationSettingsState());
    });
  }

  Future<Position> getGpsLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location Off');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Denied');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<bool> openSettings() async {
    return await Geolocator.openAppSettings();
  }
}
