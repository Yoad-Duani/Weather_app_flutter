import 'package:flutter/material.dart';
import 'package:clima2/utilities/constants.dart';

//
/// I use this widget has a child for 'SunriseAndSunsetWidget'  widget
//
class MoreDetailsWeatherWidget extends StatelessWidget {
  const MoreDetailsWeatherWidget({
    @required this.temperatureFeeLikes,
    @required this.humidityWeatherData,
    @required this.probabilityOfPrecipitation,
    @required this.pressure,
    @required this.speedWind,
    @required this.uvIndex,
  });

  final int temperatureFeeLikes;
  final int humidityWeatherData;
  final int probabilityOfPrecipitation;
  final int pressure;
  final double speedWind;
  final double uvIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Feels like',
                  style: kMoreDetailsWeatherTitle,
                ),
              ),
              Expanded(
                child: Text(
                  'humidity',
                  style: kMoreDetailsWeatherTitle,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  '$temperatureFeeLikes°',
                  style: kMoreDetailsWeatherData,
                ),
              ),
              Expanded(
                child: Text(
                  '$humidityWeatherData%',
                  style: kMoreDetailsWeatherData,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Chance of rain',
                  style: kMoreDetailsWeatherTitle,
                ),
              ),
              Expanded(
                child: Text(
                  'pressure',
                  style: kMoreDetailsWeatherTitle,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  '$probabilityOfPrecipitation%',
                  style: kMoreDetailsWeatherData,
                ),
              ),
              Expanded(
                child: Text(
                  '$pressure mbar',
                  style: kMoreDetailsWeatherData,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Wind speed',
                  style: kMoreDetailsWeatherTitle,
                ),
              ),
              Expanded(
                child: Text(
                  'UV index',
                  style: kMoreDetailsWeatherTitle,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  '$speedWind km/h',
                  style: kMoreDetailsWeatherData,
                ),
              ),
              Expanded(
                child: Text(
                  '$uvIndex',
                  style: kMoreDetailsWeatherData,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
