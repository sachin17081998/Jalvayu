part of 'internet_bloc.dart';

@immutable
abstract class InternetEvent {}

class CheckInternetEvent extends InternetEvent {}

class InternetLostEvent extends InternetEvent {}

class InternetGainedEvent extends InternetEvent {
  final ConnectionType type;
  InternetGainedEvent(this.type);
}
