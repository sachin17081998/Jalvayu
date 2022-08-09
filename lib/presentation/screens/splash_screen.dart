import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jalavaayu/presentation/screens/check_internet.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
     Navigator.of(context).pushReplacementNamed('/homescreen'); 
         
      // Navigator.pushReplacement(context,
      //     MaterialPageRoute(builder: (context) => const CheckInternet()));
     
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height*0.8,
          width: MediaQuery.of(context).size.width*0.8,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/PngLogo/LaunchLogo.png"),
              // fit: BoxFit.fitWidth
            ),
          ),
        ),
      ),
    );
  }
}
