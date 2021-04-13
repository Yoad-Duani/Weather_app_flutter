import 'package:flutter/material.dart';
import 'package:clima2/utilities/constants.dart';
import 'package:clima2/components/weatherIcon.dart';

class MainDataWidget extends StatelessWidget {
  const MainDataWidget({
    @required this.weatherDescription,
    @required this.temperature,
    @required this.weatherIconAPI,
    @required this.speedWind,
  });

  final String weatherDescription;
  final int temperature;
  final String weatherIconAPI;
  final double speedWind;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 100.0,
          ),
          Text(
            '$weatherDescription',
            style: kConditionTextStyleTheText,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$temperature°',
                style: kTempTextStyle,
              ),
              // weatherIcon,
              WeatherIcon(
                iconSymbol: weatherIconAPI,
              ),
            ],
          ),
          Text(
            'speed wind: $speedWind km/h',
            style: kWindSpeedTextStyle,
          ),
          SizedBox(
            height: 25.0,
          ),
        ],
      ),
    );
  }
}
