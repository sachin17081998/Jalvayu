import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/bloc/Internetbloc/internet_bloc.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetBloc, InternetState>(
      listener: (context, state) {
       if (state is InternetConnectedState) {
          // Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacementNamed('/homescreen');
          
        } else if (state is InternetDisconnectedState) {
          // Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.of(context).pushReplacementNamed('/noInternet');
        }
      },
      child: Scaffold(
        body: Center(
          child: Container(
              height: MediaQuery.of(context).size.height*0.6 ,
              width: MediaQuery.of(context).size.width ,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/PngLogo/noInternet.png"),
                  // fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Column(
                  children: const [
                    SizedBox(
                      height: 0,
                    ),
                    Text('No Connection',
                        style: TextStyle(
                            color: Color(0xFF263238),
                            fontSize: 24,
                            fontWeight: FontWeight.w700)),
                    Text('Check your Internet Connection',
                        style: TextStyle(
                            color: Color(0xFF263238),
                            fontSize: 14,
                            fontWeight: FontWeight.w200)),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
