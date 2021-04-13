import 'package:flutter/material.dart';
import 'package:clima2/services/weather.dart';

class WeatherIcon extends StatelessWidget {
  WeatherModel weatherIcon = WeatherModel();
  String iconSymbol;
  String nameIcon;

  void getIconWeather() {
    nameIcon = weatherIcon.getWeatherIconPNG(iconSymbol);
  }

  WeatherIcon({@required this.iconSymbol});

  @override
  Widget build(BuildContext context) {
    getIconWeather();
    return Image.asset('images/$nameIcon.png');
  }
}
