import 'package:intl/intl.dart';

class Weather {
  final String place;
  final String main;
  final String description;
  final String icon;
  final String temperatur;
  final String humidity;
  final String windspeed;
  final int dateTime;
  final int sunrise;
  final int sunset;
  final int pressure;

  const Weather(
      {required this.place,
      required this.main,
      required this.description,
      required this.icon,
      required this.temperatur,
      required this.humidity,
      required this.windspeed,
      required this.dateTime,
      required this.sunrise,
      required this.sunset,
      required this.pressure});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        place: json['name'],
        main: json['weather'][0]['main'],
        description: json['weather'][0]['description'],
        icon: json['weather'][0]['icon'],
        temperatur: json['main']['temp'].toString(),
        humidity: json['main']['humidity'].toString(),
        windspeed: json['wind']['speed'].toString(),
        dateTime: json['dt'],
        sunrise: json['sys']['sunrise'],
        sunset: json['sys']['sunset'],
        pressure: json['main']['pressure']);
  }
  Map getDate() {
    var x = DateTime.fromMillisecondsSinceEpoch(dateTime * 1000);
    var sunRise = DateTime.fromMillisecondsSinceEpoch(sunrise * 1000);
    var sunSet = DateTime.fromMillisecondsSinceEpoch(sunset * 1000);
    Map data = new Map();
    data['day'] = getDay(x.weekday);
    data['time'] = DateFormat('hh:mm a').format(x).toString();
    data['sunrise']=DateFormat('hh:mm a').format(sunRise).toString();
    data['sunset']=DateFormat('hh:mm a').format(sunSet).toString();
    // String am_pm = x;
    return data;
  }

  String getDay(int day) {
    switch (day) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }

  String getIcon() {
    switch (icon.substring(0, 2)) {
      case "01":
        return 'assets/PngLogo/01.png';
      case "02":
        return 'assets/PngLogo/02.png';
      case "03":
        return 'assets/PngLogo/03.png';
      case "04":
        return 'assets/PngLogo/04.png';
      case "09":
        return 'assets/PngLogo/09.png';
      case "10":
        return 'assets/PngLogo/09.png';
      case "11":
        return 'assets/PngLogo/11.png';
      case "13":
        return 'assets/PngLogo/13.png';
      case "50":
        return 'assets/PngLogo/50.png';
      default:
        return 'assets/PngLogo/default.png';
    }
  }
}
