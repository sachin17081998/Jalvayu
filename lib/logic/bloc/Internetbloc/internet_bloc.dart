import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:jalavaayu/constants/constants.dart';
import 'package:meta/meta.dart';

part 'internet_event.dart';
part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription connectivityStreamSubscription;

  InternetBloc() : super(InternetCheckingState()) {
    checkInternetConnection().then((value) {
      add(InternetLostEvent());
    });
    connectivityStreamSubscription =
        _connectivity.onConnectivityChanged.listen((result) {
      
      bool isConnected = false;
      checkInternetConnection().then((value) {
        isConnected = value;
         if (result.name == ConnectionType.mobile.name && isConnected) {
        add(InternetGainedEvent(ConnectionType.mobile));
      } else if (result.name == ConnectionType.wifi.name && isConnected) {
        add(InternetGainedEvent(ConnectionType.wifi));
      } else {
        add(InternetLostEvent());
      }
      });
    });

    
    on<CheckInternetEvent>((event, emit) {
      emit(InternetCheckingState());
    });
    on<InternetLostEvent>((event, emit) {
      emit(InternetDisconnectedState());
    });
    on<InternetGainedEvent>((event, emit) {
      emit(InternetConnectedState(connectionType: event.type));
    });
  }

  Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
