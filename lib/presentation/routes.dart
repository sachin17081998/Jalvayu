import 'package:flutter/material.dart';
import 'package:jalavaayu/presentation/screens/check_internet.dart';
import 'package:jalavaayu/presentation/screens/home_screen.dart';
import 'package:jalavaayu/presentation/screens/no_internet_screen.dart';
import 'package:jalavaayu/presentation/screens/splash_screen.dart';



class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case '/home':
        return MaterialPageRoute(
          builder: (_) => const HomeScreen()
        );
      case '/noInternet':
        return MaterialPageRoute(
          builder: (_) => const NoInternetScreen()
        );
      // case '/checkInternet':
      //   return MaterialPageRoute(
      //     builder: (_) => const CheckInternet()
      //   );   
      default:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen()
        );
    }
  }
}
