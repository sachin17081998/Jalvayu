part of 'internet_bloc.dart';

@immutable
abstract class InternetState {}

class InternetCheckingState extends InternetState {}

class InternetConnectedState extends InternetState {
  final ConnectionType connectionType;
  InternetConnectedState({required this.connectionType});
}

class InternetDisconnectedState extends InternetState{}

