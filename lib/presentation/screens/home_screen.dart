import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jalavaayu/data/provider/weatherAPI.dart';
import 'package:jalavaayu/data/repository/weather_repository.dart';
import 'package:jalavaayu/logic/bloc/Gpsbloc/gps_bloc.dart';
import 'package:jalavaayu/logic/bloc/weatherbloc/weather_bloc.dart';

import '../../data/model/weather_modl.dart';
import '../../logic/bloc/Internetbloc/internet_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showTextField = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<InternetBloc, InternetState>(
          listener: (context, state) {
            if (state is InternetConnectedState) {
              // Navigator.of(context).popUntil((route) => route.isFirst);

              Navigator.of(context).pushReplacementNamed('/homescreen');
            } else if (state is InternetDisconnectedState) {
              // Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.of(context).pushReplacementNamed('/noInternet');
            }
          },
        ),
        BlocListener<GpsBloc, GpsState>(
          listener: (context, state) {
            if (state is GpsLoadingState) {
              BlocProvider.of<WeatherBloc>(context).add(WeatherLoadingEvent());
            } else if (state is GpsWeatherFetchedState) {
              BlocProvider.of<WeatherBloc>(context).add(GetWeatherByGpsEvent(
                  latitutde: state.latitude, longitude: state.longitude));
            } else if (state is GpsAccessDenied) {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text(
                      "Location Access Denied. Allow Jalvayu to access your location"),
                  actions: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<GpsBloc>(context)
                            .add(OpenLocationSettingsEvent());
                        Navigator.of(ctx).pop();
                      },
                      child: const Text("Open Settings"),
                    ),
                  ],
                ),
              );
            } else if (state is GpsErrorState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.msg)));
            } else if (state is GpsOffState) {
              // ScaffoldMessenger.of(context).showSnackBar(
              //     const SnackBar(content: Text("GPS/Location is off!")));
              BlocProvider.of<WeatherBloc>(context).add(WeatherGpsOffEvent());
              // .add(WeatherLoadedEvent(data: data));
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xFFf1faee),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                if (showTextField)
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: 50,
                      child: TextField(
                        autofocus: true,
                        style: const TextStyle(
                            color: Color(0xFF263238), fontSize: 20),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFf1faee),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xFF263238), width: 0.0),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onSubmitted: (text) {
                          setState(() {
                            showTextField = !showTextField;
                            if (text.isNotEmpty) {
                              BlocProvider.of<WeatherBloc>(context)
                                  .add(FetchWeatherEvent(place: text));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Enter a valid city name')));
                            }
                          });
                        },
                      ),
                    ),
                  ),
                if (!showTextField)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: IconButton(
                            iconSize: 30,
                            onPressed: () {
                              BlocProvider.of<GpsBloc>(context)
                                  .add(FetchGpsEvent());
                            },
                            icon: const Icon(
                              Icons.gps_fixed_rounded,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: IconButton(
                            iconSize: 30,
                            onPressed: () {
                              setState(() {
                                showTextField = !showTextField;
                              });
                            },
                            icon: const Icon(
                              Icons.search,
                            )),
                      ),
                    ],
                  ),
                BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is InitialState) {
                      BlocProvider.of<WeatherBloc>(context)
                          .add(FetchWeatherEvent(place: 'delhi'));
                      return WeatherColumn(state.initialWeatherData);
                    } else if (state is WeatherLoadedState) {
                      return WeatherColumn(state.weatherData);
                    } else if (state is WeatherLoadingState) {
                      return const CircularProgressIndicator();
                    } else if (state is WeatherErrorState) {
                      return errorWidget(context, state.errorMsg);
                    } else if (state is WeatherGpsOffState) {
                      return errorWidget(context,
                          'Your Location is off.');
                    } else {
                      return errorWidget(context,
                          'Something went Wrong. Check your internet connection and try again');
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column WeatherColumn(Weather data) {
    Map dT = data.getDate();
    const int $deg = 0x00B0;
    // String day = dT.weekday;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          data.place,
          style: Theme.of(context).textTheme.headline1,
        ),
        Text(
          dT['day'] + ' ' + dT['time'],
          style: Theme.of(context).textTheme.bodyText2,
        ),
        Image.asset(
          data.getIcon(),
          width: MediaQuery.of(context).size.width * 0.80,
          height: MediaQuery.of(context).size.height * 0.40,
          fit: BoxFit.fitWidth,
        ),
        const SizedBox(height: 10),
        Text(
          '${data.temperatur} \u2103 ',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          data.description,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            card(data.humidity, 'Humidity'),
            const SizedBox(
              width: 50,
            ),
            card(data.windspeed, 'Windspeed')
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            card2(dT['sunrise'], 'Sunrise'),
            divider(),
            card2(dT['sunset'], 'Sunset'),
            divider(),
            card2(data.pressure.toString(), 'Pressure'),
          ],
        )
      ],
    );
  }

  SizedBox card(String data, String text) {
    return SizedBox(
      height: 80,
      width: 80,
      child: Card(
        color: const Color(0xFF263238),
        shadowColor: Color.fromARGB(255, 160, 162, 163),
        elevation: 10,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                data,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.subtitle2,
              )
            ]),
      ),
    );
  }

  SizedBox card2(String data, String text) {
    return SizedBox(
      height: 100,
      child: Column(
        children: [
          Text(
            data,
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyText2,
          )
        ],
      ),
    );
  }

  Padding divider() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          width: 2,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            color: const Color.fromARGB(78, 63, 67, 70),
          )),
    );
  }
}

Column errorWidget(BuildContext context, String error) {
  return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              error,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                          const SizedBox(height: 100),
                          Image.asset(
                            'assets/PngLogo/error2.png',
                          )
                        ],
                      );
}
