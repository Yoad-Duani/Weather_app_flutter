import 'package:flutter/material.dart';
import 'package:clima2/services/weather.dart';

class WeatherDayWidget extends StatelessWidget {
  WeatherDayWidget({
    @required this.dayName,
    @required this.iconCode,
    @required this.maxTemp,
    @required this.minTemp,
  });

  WeatherModel weatherIcon = WeatherModel();
  final dayName;
  final iconCode;
  final maxTemp;
  final minTemp;

  String nameIcon;

  void getIconWeather() {
    nameIcon = weatherIcon.getWeatherIconPNG(iconCode);
  }

  @override
  Widget build(BuildContext context) {
    getIconWeather();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            dayName,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        Expanded(
          flex: 3,
          child: Image.asset(
            'images/$nameIcon.png',
            height: 32.0,
            width: 32.0,
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            '$maxTemp°',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        Text(
          '$minTemp°',
          style: TextStyle(fontSize: 20.0, color: Colors.white.withOpacity(0.6)),
        ),
      ],
    );
  }
}
