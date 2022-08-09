import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jalavaayu/constants/constants.dart';

import '../../logic/bloc/Internetbloc/internet_bloc.dart';

class WeatherDetailScreen extends StatelessWidget {
  const WeatherDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocBuilder<InternetBloc, InternetState>(
        builder: (context, state) {
          if (state is InternetConnectedState) {
            if (state.connectionType == ConnectionType.wifi) {
              return const Text('Wifi');
            } else {
              return const Text('Mobile');
            }
          } else if (state is InternetDisconnectedState) {
            return const Text('No Internet');
          } else {
            // print(state);
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
