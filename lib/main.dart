import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jalavaayu/logic/bloc/Internetbloc/internet_bloc.dart';
import 'package:jalavaayu/presentation/routes.dart';

import 'logic/bloc/Gpsbloc/gps_bloc.dart';
import 'logic/bloc/weatherbloc/weather_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final AppRouter appRouter = AppRouter();
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetBloc>(
          create: (context) => InternetBloc(),
        ),
        BlocProvider<WeatherBloc>(
          create: (context) => WeatherBloc(),
        ),
          BlocProvider<GpsBloc>(
          create: (context) => GpsBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color(0xFF92E3A9),
            secondary: const Color(0xFF263238),
          ),
          textTheme: TextTheme(
              headline1: GoogleFonts.roboto(
                  color: const Color(0xFF033f3f),
                  fontSize: 50,
                  fontWeight: FontWeight.bold),
              headline2: GoogleFonts.roboto(
                  color: const Color(0xFF263238),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              bodyText1: GoogleFonts.roboto(
                  fontSize: 40.0,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 63, 67, 70)),
              bodyText2: GoogleFonts.robotoCondensed(
                  fontSize: 16.0,
                  fontStyle: FontStyle.italic,
                  color: const Color(0xFF263238)),
              
              subtitle1:GoogleFonts.robotoCondensed(
                  fontSize: 30.0,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFFf4f3ee)),
                     subtitle2:GoogleFonts.robotoCondensed(
                  fontSize: 15.0,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFFf4f3ee))     
                  
                  ),
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
