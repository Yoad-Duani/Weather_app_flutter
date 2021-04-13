import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:clima2/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  var weatherData;
  var weatherHourlyForecastData;
  var airQuality;

  void getLocationData() async {
    WeatherModel weatherModel = WeatherModel();

    var location = await weatherModel.checkPermissionAndLocation();
    if (location != null) {
      final result = await Future.wait([
        weatherModel.getLocationWeather(location),
        weatherModel.getLocationWeatherHourlyForecast(location),
        weatherModel.getLocationAirQualityIndex(location),
      ]);
      // if (result[0] != null && result[1] != null && result[2]) {
      weatherData = result[0];
      weatherHourlyForecastData = result[1];
      airQuality = result[2];

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return LocationScreen(
          locationWeather: weatherData,
          locationWeatherHourlyForecast: weatherHourlyForecastData,
          locationAirQualityIndex: airQuality,
        );
      }));
    } else {
      getLocationData();
    }
  }

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Gets Your Location...',
              style: TextStyle(
                fontSize: 35.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12.0),
            SpinKitRing(
              color: Colors.white,
              size: 100.0,
            ),
          ],
        ),
      ),
    );
  }
}
