import 'package:clima2/services/networking.dart';
import 'package:clima2/services/location.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

const apiKeyAqicn = '7b926ebfa510b71fc5e0927259116d05a71d2b62'; // api Key from https://aqicn.org
const apiKeyOpenWeatherMap = '373e1daca8dc0b0173a837bd26101e42'; // api key from https://openweathermap.org/
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather'; //URL for Current weather data
const openWeatherMapHourlyForecastURL = 'https://api.openweathermap.org/data/2.5/onecall'; //URL for Hourly forecast weather data
const aqicnAirQualityIndexURL = 'https://api.waqi.info/feed'; //URL for Air quality index

class WeatherModel {
  ///Checks and requests location permission, returns location If approved location
  Future<dynamic> checkPermissionAndLocation() {
    Location location = Location();
    return location.checkPermissionLocation();
    //todo:
  }

  ///Returns the JSON format of the current weather, according to points(latitude, longitude) received
  Future<dynamic> getLocationWeather(Position location) async {
    NetworkingHelper networkingHelper =
        NetworkingHelper(url: '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKeyOpenWeatherMap&units=metric');
    var weatherData = await networkingHelper.getData();
    return weatherData;
  }

  ///Returns the JSON format of the current weather, according to points(latitude, longitude) received - after user pick location
  Future<dynamic> getLocationWeatherLatLog(double lat, double log) async {
    NetworkingHelper networkingHelper = NetworkingHelper(url: '$openWeatherMapURL?lat=$lat&lon=$log&appid=$apiKeyOpenWeatherMap&units=metric');
    var weatherData = await networkingHelper.getData();
    return weatherData;
  }

  ///Returns the JSON format of the Hourly and day Forecast weather, according to points(latitude, longitude) received
  Future<dynamic> getLocationWeatherHourlyForecast(Position location) async {
    NetworkingHelper networkingHelper = NetworkingHelper(
        url: '$openWeatherMapHourlyForecastURL?lat=${location.latitude}&lon=${location.longitude}&exclude=minutely&appid=$apiKeyOpenWeatherMap&units=metric');
    var weatherData = await networkingHelper.getData();
    return weatherData;
  }

  ///Returns the JSON format of the Hourly and day Forecast weather, according to points(latitude, longitude) received - after user pick location
  Future<dynamic> getLocationWeatherHourlyForecastLatLog(double lat, double log) async {
    NetworkingHelper networkingHelper =
        NetworkingHelper(url: '$openWeatherMapHourlyForecastURL?lat=$lat&lon=$log&exclude=minutely&appid=$apiKeyOpenWeatherMap&units=metric');
    var weatherData = await networkingHelper.getData();
    return weatherData;
  }

  ///Returns the JSON format of the air quality , according to points(latitude, longitude) received
  Future<dynamic> getLocationAirQualityIndex(Position location) async {
    NetworkingHelper networkingHelper = NetworkingHelper(url: '$aqicnAirQualityIndexURL/geo:${location.latitude};${location.longitude}/?token=$apiKeyAqicn');
    var airQuality = await networkingHelper.getData();
    return airQuality;
  }

  ///Returns the JSON format of the air quality , according to points(latitude, longitude) received - after user pick location
  Future<dynamic> getLocationAirQualityIndexLatLog(double lat, double log) async {
    NetworkingHelper networkingHelper = NetworkingHelper(url: '$aqicnAirQualityIndexURL/geo:$lat;$log/?token=$apiKeyAqicn');
    var airQuality = await networkingHelper.getData();
    return airQuality;
  }

  //
  //
  //
  //
  //
  //
  ///Functions get for style location_screen depending on the weather
  LinearGradient getBackgroundColorWeather(String conditionSymbol) {
    switch (conditionSymbol) {
      case '01d':
        {
          //sun
          return LinearGradient(
            begin: Alignment.topLeft,
            stops: [0.0, 0.015, 0.16],
            end: Alignment.bottomRight,
            colors: [
              Colors.yellow[300],
              Colors.yellow[200],
              Color(0xFF498fe1),
              // Colors.black,
              // Color(0xFF87CEFA),
              // Colors.lightBlue[600],
            ],
          );
        }
        break;
      case '10d':
      case '02d':
        {
          //sun and clouds
          return LinearGradient(
            begin: Alignment.topLeft,
            stops: [0.01, 0.02, 0.16, 0.6],
            end: Alignment.bottomRight,
            colors: [
              Colors.yellow[300],
              Colors.yellow[200],
              Colors.grey[400],
              Color(0xFF498fe1),
            ],
          );
        }
        break;
      case '01n':
        {
          //night
          return LinearGradient(
            begin: Alignment.topLeft,
            stops: [
              0.0,
              0.4,
            ],
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF3c3778),
              Color(0xFF546bab),
            ],
          );
        }
        break;
      case '02n':
      case '10n':
        {
          //night and clouds
          return LinearGradient(
            begin: Alignment.topLeft,
            stops: [0.0, 0.4, 0.8],
            end: Alignment.bottomRight,
            colors: [
              Colors.grey[800],
              Color(0xFF3c3778),
              Color(0xFF546bab),
            ],
          );
        }
        break;
      case '04d':
      case '04n':
      case '03d':
      case '03n':
      case '09d':
      case '09n':
      case '11d':
      case '11n':
      case '50d':
      case '50n':
      case '13d':
      case '13n':
        {
          //clouds
          return LinearGradient(
            begin: Alignment.topLeft,
            stops: [0.0, 1.0],
            end: Alignment.bottomRight,
            colors: [
              Colors.grey[500],
              Colors.grey[600],
            ],
          );
        }
        break;

      default:
        {
          return LinearGradient();
        }
        break;
    }
  }

  String getWeatherIconPNG(String conditionSymbol) {
    switch (conditionSymbol) {
      case '01d':
        {
          return 'sun';
        }
        break;

      case '02d':
        {
          return 'sunClouds';
        }
        break;
      case '03d':
      case '03n':
        {
          return 'clouds';
        }
        break;
      case '04d':
      case '04n':
        {
          return 'clouds';
        }
        break;
      case '09d':
      case '09n':
        {
          return 'rain';
        }
        break;
      case '10d':
        {
          return 'sunCloudsRain';
        }
        break;
      case '11d':
      case '11n':
        {
          return 'strom';
        }
        break;
      case '13d':
      case '13n':
        {
          return 'snow';
        }
        break;
      case '50d':
      case '50n':
        {
          return 'mistOrFog';
        }
        break;
      case '01n':
        {
          return 'moon';
        }
        break;
      case '02n':
        {
          return 'moonClouds';
        }
        break;
      case '10n':
        {
          return 'moonCloudsRain';
        }
        break;

      default:
        {
          return 'sun';
        }
        break;
    }
  }

  String getWeatherIconPNGonlyNight(String conditionSymbol) {
    switch (conditionSymbol) {
      case '03d':
      case '03n':
        {
          return 'clouds';
        }
        break;
      case '04d':
      case '04n':
        {
          return 'clouds';
        }
        break;
      case '09d':
      case '09n':
        {
          return 'rain';
        }
        break;
      case '11d':
      case '11n':
        {
          return 'strom';
        }
        break;
      case '13d':
      case '13n':
        {
          return 'snow';
        }
        break;
      case '50d':
      case '50n':
        {
          return 'mistOrFog';
        }
        break;
      case '01d':
      case '01n':
        {
          return 'moon';
        }
        break;
      case '02d':
      case '02n':
        {
          return 'moonClouds';
        }
        break;
      case '10d':
      case '10n':
        {
          return 'moonCloudsRain';
        }
        break;

      default:
        {
          return 'moon';
        }
        break;
    }
  }

  //
  //
  //
  //
  //
  //
  ///Functions get for style airQuality_screen depending on air quality
  List getAirQualityIndexColor(var airQualityIndex) {
    if (airQualityIndex <= 50) {
      return [
        Color(0XFF3CB371),
        'Good',
        'Air quality is considered satisfactory, and air pollution poses little or no risk',
      ];
    } else {
      if (airQualityIndex <= 100) {
        return [
          Colors.yellow[600],
          'Moderate',
          'Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people who are unusually sensitive to air pollution',
        ];
      } else {
        if (airQualityIndex <= 150) {
          return [
            Colors.orange,
            'Unhealthy for Sensitive Groups',
            'Members of sensitive groups may experience health effects. The general public is not likely to be affected.',
          ];
        } else {
          if (airQualityIndex <= 250) {
            return [
              Colors.red,
              'Unhealthy',
              'Everyone may begin to experience health effects; members of sensitive groups may experience more serious health effects.',
            ];
          } else {
            return [
              Colors.red[900],
              'Very Unhealthy	',
              'Health warnings of emergency conditions.',
            ];
          }
        }
      }
    }
  }

  List getAirQualityMoleculesColor(List airMolecules) {}
}
