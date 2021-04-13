import 'package:clima2/components/reusable_card.dart';
import 'package:flutter/material.dart';
import 'package:clima2/services/weather.dart';
import 'package:clima2/components/weatherHourWidget.dart';
import 'package:intl/intl.dart';
import 'package:clima2/components/weatherDayWidget.dart';
import 'package:clima2/components/sunriseAndSunsetWidget.dart';
import 'package:clima2/components/mainDataWidget.dart';
import 'package:clima2/components/airQualityIndexWidget.dart';
import 'package:clima2/screens/SevenDayForecast_screen.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

// extension Ex on double {
//   double toPrecision(int n) => double.parse(toStringAsFixed(n));
// }

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather, this.locationWeatherHourlyForecast, this.locationAirQualityIndex});

  final locationWeather;
  var locationWeatherHourlyForecast;
  var locationAirQualityIndex;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();

  List<WeatherHourWidget> weatherHourList = [];
  List<WeatherDayWidget> weatherDayList = [];

  int temperature;
  Icon weatherIcon;
  String cityName;
  String messageWeather;
  String weatherDescription;
  double speedWind;
  String weatherIconAPI;
  LinearGradient backgroundColorWeather;
  var temperatureFeeLikes;
  var humidityWeatherData;
  var pressure;
  double uvIndex;
  var probabilityOfPrecipitation;
  String hourStringSunrise;
  String hourStringSunset;
  double hourDoubleSunrise;
  double hourDoubleSunset;
  double hourDoubleNow;
  int airQualityIndex;
  String airQualityIndexTime;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather, widget.locationWeatherHourlyForecast, widget.locationAirQualityIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                gradient: backgroundColorWeather,
              ),
              height: 1400.0,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                // mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ///"appbar"  - start
                  Container(
                    color: Colors.grey[800].withOpacity(0.3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextButton(
                          onPressed: () async {
                            weatherHourList = [];
                            weatherDayList = [];
                            var weatherData;
                            var weatherDataHourlyForecast;
                            var airQualityIx;

                            var location = await weather.checkPermissionAndLocation();
                            if (location != null) {
                              final result = await Future.wait([
                                weather.getLocationWeather(location),
                                weather.getLocationWeatherHourlyForecast(location),
                                weather.getLocationAirQualityIndex(location),
                              ]);
                              weatherData = result[0];
                              weatherDataHourlyForecast = result[1];
                              airQualityIx = result[2];
                              widget.locationWeatherHourlyForecast = result[1];
                              widget.locationAirQualityIndex = result[2];
                              updateUI(weatherData, weatherDataHourlyForecast, airQualityIx);
                            }
                          },
                          child: Icon(
                            Icons.place,
                            size: 35.0,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '$cityName',
                          style: TextStyle(
                            fontSize: 25.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            Prediction prediction = await PlacesAutocomplete.show(
                                context: context,
                                apiKey: 'AIzaSyAULnGJXpQHJAjxbPUlUYw1-S4XPkdpOIs',
                                mode: Mode.fullscreen, // Mode.overlay
                                language: "en",
                                components: [Component(Component.country, "il")]);
                            if (prediction != null) {
                              var typedNameCityList = await _getLatLng(prediction);
                              var weatherData;
                              var weatherDataHourlyForecast;
                              var airQualityInx;
                              if (typedNameCityList[2] != null) {
                                final result = await Future.wait([
                                  weather.getLocationWeatherLatLog(typedNameCityList[0], typedNameCityList[1]),
                                  weather.getLocationWeatherHourlyForecastLatLog(typedNameCityList[0], typedNameCityList[1]),
                                  weather.getLocationAirQualityIndexLatLog(typedNameCityList[0], typedNameCityList[1]),
                                ]);
                                weatherData = result[0];
                                weatherDataHourlyForecast = result[1];
                                airQualityInx = result[2];
                                widget.locationWeatherHourlyForecast = result[1];
                                widget.locationAirQualityIndex = result[2];
                                updateUI(weatherData, weatherDataHourlyForecast, airQualityInx);
                              }
                            }
                          },
                          child: Icon(
                            Icons.location_city,
                            size: 35.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///"appbar"  - end

                  ///here display the mian data the current weather , ( temp , description of the weather , speed wind ,icon)
                  MainDataWidget(
                    weatherDescription: weatherDescription,
                    temperature: temperature,
                    weatherIconAPI: weatherIconAPI,
                    speedWind: speedWind,
                  ),
                  SizedBox(
                    height: 15.0,
                  ),

                  ///here display weatherDayList ( 3 days)
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 18.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: weatherDayList,
                      ),
                    ),
                  ),

                  ///button for 7 days forecast
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 25.0,
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return SevenDayForecastScreen(
                            locationWeatherHourlyForecast: widget.locationWeatherHourlyForecast,
                          );
                        }));
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(Colors.white.withOpacity(0.25)),
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Forecast for 7 days',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),

                  ///here display weather Hour List (24 hours)
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        reverse: true,
                        children: weatherHourList,
                      ),
                    ),
                  ),

                  ///here display SunriseAndSunsetWidget and his child moreDetailsWeatherWidget
                  Expanded(
                    flex: 2,
                    child: ReusableCard(
                      color: Colors.white,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SunriseAndSunsetWidget(
                              hourDoubleNow: hourDoubleNow,
                              temperatureFeeLikes: temperatureFeeLikes,
                              humidityWeatherData: humidityWeatherData,
                              probabilityOfPrecipitation: probabilityOfPrecipitation,
                              pressure: pressure,
                              speedWind: speedWind,
                              uvIndex: uvIndex,
                              hourStringSunrise: hourStringSunrise,
                              hourStringSunset: hourStringSunset,
                              hourDoubleSunrise: hourDoubleSunrise,
                              hourDoubleSunset: hourDoubleSunset,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 18.0,
                  ),

                  ///here display AirQualityWidget
                  ReusableCard(
                    color: Colors.white,
                    cardChild: AirQualityWidget(
                      airQualityIndex: airQualityIndex,
                      cityName: cityName,
                      airData: widget.locationAirQualityIndex,
                      hourTime: airQualityIndexTime,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Most information is taken from ',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 11.0,
                          ),
                        ),
                        Text(
                          'OpenWeatherMap',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<List> _getLatLng(Prediction prediction) async {
    GoogleMapsPlaces _places = new GoogleMapsPlaces(apiKey: 'AIzaSyAULnGJXpQHJAjxbPUlUYw1-S4XPkdpOIs'); //Same API_KEY as above
    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(prediction.placeId);
    double latitude = detail.result.geometry.location.lat;
    double longitude = detail.result.geometry.location.lng;
    String address = prediction.description;
    List lst = [latitude, longitude, address];
    print(latitude);
    print(longitude);
    print(address);
    return lst;
  }

  //
  //
  //
  //
  ///The main function for data updates
  void updateUI(dynamic weatherData, dynamic weatherDataHourlyForecast, dynamic airQualityI) {
    setState(() {
      if (weatherData == null || weatherDataHourlyForecast == null) {
        temperature = 0;
        messageWeather = 'Unable to get weather data';
        cityName = '';
        weatherDescription = '';
        speedWind = 0.0;
        return;
      }
      weatherDayList = [];
      weatherHourList = [];
      var temp = weatherDataHourlyForecast['current']['temp'];
      temperature = temp.toInt();
      cityName = weatherData['name'];
      weatherDescription = weatherData['weather'][0]['description'];
      speedWind = (weatherData['wind']['speed']) * 3.6; // metter per seceond to km in hour
      speedWind = speedWind.toPrecision(2);
      weatherIconAPI = weatherData['weather'][0]['icon'];
      backgroundColorWeather = weather.getBackgroundColorWeather(weatherData['weather'][0]['icon']); // get the background color according to the weather outside
      airQualityIndex = airQualityI['data']['aqi']; // the main air quality index
      createWeatherHourList(weatherDataHourlyForecast);
      createWeatherDayList(weatherDataHourlyForecast);
      getWeatherDataMoreDetails(weatherDataHourlyForecast);
      airQualityIndexTime = weatherHourList[0].hourTime; // save the time now for air quality index screen
    });
  }

  //
  //
  ///Creates a list of WeatherHourWidget , this list will display on Listview
  void createWeatherHourList(dynamic weatherDataHourlyForecast) {
    var hour;
    var temperature;
    String iconCode;
    double speedWind;

    for (var i = 0; i <= 24; i++) {
      //TODO const to offset 24 ( the numbers of hours are display)
      //
      var myAPIEpochTimeInMilliseconds = (weatherDataHourlyForecast['hourly'][i]['dt']) + weatherDataHourlyForecast['timezone_offset'];
      DateTime date = new DateTime.fromMillisecondsSinceEpoch(myAPIEpochTimeInMilliseconds * 1000).toUtc();
      //+ weatherDataHourlyForecast['timezone_offset']
      var format = new DateFormat('HH:mm');
      var dateString = format.format(date);
      hour = dateString;
      //
      var temp = weatherDataHourlyForecast['hourly'][i]['temp'];
      temperature = temp.toInt();
      //
      iconCode = weatherDataHourlyForecast['hourly'][i]['weather'][0]['icon'];
      //
      speedWind = (weatherDataHourlyForecast['hourly'][i]['wind_speed']) * 3.6;
      speedWind = speedWind.toPrecision(2);

      weatherHourList.add(
        WeatherHourWidget(
          hourTime: hour,
          temperature: temperature,
          iconCode: iconCode,
          speedWind: speedWind,
        ),
      );
    }
  }

  //
  //
  /// Creates a list of WeatherDayWidget ,
  void createWeatherDayList(dynamic weatherDataHourlyForecast) {
    var dayName;
    var iconCode;
    var maxTemp;
    var minTemp;

    for (var i = 0; i <= 2; i++) {
      //TODO const to offset 2 ( the numbers of days are display)
      var myAPIEpochTimeInMilliseconds = (weatherDataHourlyForecast['daily'][i]['dt']);
      DateTime date = new DateTime.fromMillisecondsSinceEpoch(myAPIEpochTimeInMilliseconds * 1000);
      var format = new DateFormat('EEEE');
      dayName = format.format(date);

      iconCode = weatherDataHourlyForecast['daily'][i]['weather'][0]['icon'];

      var tempMAX = weatherDataHourlyForecast['daily'][i]['temp']['max'];
      maxTemp = tempMAX.toInt();

      var tempMIN = weatherDataHourlyForecast['daily'][i]['temp']['min'];
      minTemp = tempMIN.toInt();

      weatherDayList.add(
        WeatherDayWidget(
          dayName: dayName,
          maxTemp: maxTemp,
          minTemp: minTemp,
          iconCode: iconCode,
        ),
      );
    }
  }

  //
  //
  ///update the data for SunriseAndSunsetWidget and his child moreDetailsWeatherWidget
  void getWeatherDataMoreDetails(dynamic weatherDataHourlyForecast) {
    var feelsLike; // help var

    DateTime dateNow = DateTime.now();
    var myAPIEpochTimeInMillisecondsNow = dateNow.toUtc().microsecondsSinceEpoch / 1000 + (weatherDataHourlyForecast['timezone_offset'] * 1000);
    dateNow = new DateTime.fromMillisecondsSinceEpoch(myAPIEpochTimeInMillisecondsNow.toInt()).toUtc();

    var myAPIEpochTimeInMillisecondsSunrise = weatherDataHourlyForecast['current']['sunrise'] + weatherDataHourlyForecast['timezone_offset'];
    var myAPIEpochTimeInMillisecondsSunset = weatherDataHourlyForecast['current']['sunset'] + weatherDataHourlyForecast['timezone_offset'];

    DateTime dateSunrise = new DateTime.fromMillisecondsSinceEpoch(myAPIEpochTimeInMillisecondsSunrise * 1000).toUtc();
    DateTime dateSunset = new DateTime.fromMillisecondsSinceEpoch(myAPIEpochTimeInMillisecondsSunset * 1000).toUtc();
    // DateTime dateNow = DateTime.now();
    var format = new DateFormat('HH:mm');
    var formatForDouble = new DateFormat('HH.mm');

    hourStringSunrise = format.format(dateSunrise);
    hourStringSunset = format.format(dateSunset);
    hourDoubleSunrise = double.parse(formatForDouble.format(dateSunrise));
    hourDoubleSunset = double.parse(formatForDouble.format(dateSunset));
    hourDoubleNow = double.parse(formatForDouble.format(dateNow));

    feelsLike = weatherDataHourlyForecast['current']['feels_like'];
    temperatureFeeLikes = feelsLike.toInt();
    humidityWeatherData = weatherDataHourlyForecast['current']['humidity'];
    pressure = weatherDataHourlyForecast['current']['pressure'];
    // print(weatherDataHourlyForecast['current']['uvi'].toDouble());
    uvIndex = (weatherDataHourlyForecast['current']['uvi'].toDouble());
    probabilityOfPrecipitation = (weatherDataHourlyForecast['hourly'][0]['pop']).toInt();
  }
}
