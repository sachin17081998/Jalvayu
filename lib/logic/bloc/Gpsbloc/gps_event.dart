part of 'gps_bloc.dart';

abstract class GpsEvent extends Equatable {
  const GpsEvent();

  @override
  List<Object> get props => [];
}

class FetchGpsEvent extends GpsEvent {}

class GpsLoadingEvent extends GpsEvent {}
class GpsOffEvent extends GpsEvent {}
class GpsAcquiredEvent extends GpsEvent {
  final double latitude;
  final double longitude;
  final bool locationPermission;
  const GpsAcquiredEvent(
      {required this.latitude,
      required this.longitude,
      required this.locationPermission});
}

class GpsErrorEvent extends GpsEvent {
  final String msg;
  const GpsErrorEvent({required this.msg});
}

class GpsAccessDeniedEvent extends GpsEvent {}

class OpenLocationSettingsEvent extends GpsEvent {}
