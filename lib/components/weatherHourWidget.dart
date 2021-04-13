import 'package:flutter/material.dart';
import 'package:clima2/services/weather.dart';

class WeatherHourWidget extends StatelessWidget {
  WeatherHourWidget({
    @required this.hourTime,
    @required this.temperature,
    @required this.iconCode,
    @required this.speedWind,
  });
  WeatherModel weatherIcon = WeatherModel();
  final String hourTime; // maybe be in ot time type
  final int temperature;
  final String iconCode;
  final double speedWind;

  String nameIcon;

  void getIconWeather() {
    nameIcon = weatherIcon.getWeatherIconPNG(iconCode);
  }

  @override
  Widget build(BuildContext context) {
    getIconWeather();
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 30.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            hourTime,
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
          Text(
            '$temperature°',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          Image.asset(
            'images/$nameIcon.png',
            height: 25.0,
            width: 25.0,
          ),
          Text(
            '$speedWind km/h',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}
