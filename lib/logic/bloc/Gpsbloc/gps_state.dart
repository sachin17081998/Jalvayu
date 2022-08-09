part of 'gps_bloc.dart';

abstract class GpsState extends Equatable {
  const GpsState();

  @override
  List<Object> get props => [];
}

class GpsInitial extends GpsState {}

class GpsLoadingState extends GpsState {}

class GpsWeatherFetchedState extends GpsState {
  final double latitude;
  final double longitude;
  final bool locationPermission;
  const GpsWeatherFetchedState(
      {required this.latitude,
      required this.longitude,
      required this.locationPermission});
}

class GpsErrorState extends GpsState {
  final String msg;
  const GpsErrorState({required this.msg});
}

class GpsAccessDenied extends GpsState {}
class GpsOffState extends GpsState {}

class OpenLocationSettingsState extends GpsState {}
