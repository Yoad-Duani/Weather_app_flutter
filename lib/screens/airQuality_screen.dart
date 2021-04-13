import 'package:flutter/material.dart';
import 'package:clima2/services/weather.dart';
import 'package:clima2/utilities/constants.dart';

class AirQualityScreen extends StatefulWidget {
  AirQualityScreen({
    @required this.cityName,
    @required this.airQualityIndex,
    @required this.airData,
    @required this.hourTime,
  });

  final cityName;
  final airQualityIndex;
  final dynamic airData;
  final String hourTime;

  @override
  _AirQualityScreenState createState() => _AirQualityScreenState();
}

class _AirQualityScreenState extends State<AirQualityScreen> {
  WeatherModel weather = WeatherModel();
  var CO;
  var O3;
  var NO2;
  var SO2;
  var PM10;
  var PM2_5;

  List listColorAndDescription = [];
  String hour;

  @override
  void initState() {
    super.initState();
    updateUI(widget.airData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 50.0,
                    ),
                  ),
                ),
                Text(
                  'Air Quality Index',
                  style: TextStyle(fontSize: 28, color: Colors.black),
                ),
                Row(
                  children: [
                    Text(
                      '${widget.cityName}',
                      style: TextStyle(fontSize: 12, color: Colors.black38),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      '${widget.hourTime}',
                      style: TextStyle(fontSize: 12, color: Colors.black38),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '${widget.airQualityIndex}',
                      style: TextStyle(fontSize: 60, color: listColorAndDescription[0]),
                    ),
                    Text(
                      '${listColorAndDescription[1]}',
                      style: TextStyle(fontSize: 16, color: listColorAndDescription[0]),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  '${listColorAndDescription[2]}',
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          '$CO',
                          style: moleculesTheDataTextStyle,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'CO',
                          style: moleculesTheTileTextStyle,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '$O3',
                          style: moleculesTheDataTextStyle,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'O₃',
                          style: moleculesTheTileTextStyle,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '$NO2',
                          style: moleculesTheDataTextStyle,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'NO₂',
                          style: moleculesTheTileTextStyle,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '$SO2',
                          style: moleculesTheDataTextStyle,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'SO₂',
                          style: moleculesTheTileTextStyle,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '$PM10',
                          style: moleculesTheDataTextStyle,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'PM10',
                          style: moleculesTheTileTextStyle,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '$PM2_5',
                          style: moleculesTheDataTextStyle,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'PM2.5',
                          style: moleculesTheTileTextStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //
  //
  //
  ///update all the data based on existing data and sensors in the same area
  void updateUI(dynamic airQualityData) {
    try {
      CO = airQualityData['data']['iaqi']['co']['v'];
    } catch (e) {
      try {
        CO = airQualityData['data']['forecast']['daily']['co'][3]['avg'];
      } catch (e) {
        CO = '0';
      }
    }
    try {
      O3 = airQualityData['data']['iaqi']['o3']['v'];
    } catch (e) {
      try {
        O3 = airQualityData['data']['forecast']['daily']['o3'][3]['avg'];
      } catch (e) {
        O3 = '0';
      }
    }
    try {
      NO2 = airQualityData['data']['iaqi']['no2']['v'];
    } catch (e) {
      try {
        NO2 = airQualityData['data']['forecast']['daily']['no2'][3]['avg'];
      } catch (e) {
        NO2 = '0';
      }
    }
    try {
      SO2 = airQualityData['data']['iaqi']['so2']['v'];
    } catch (e) {
      try {
        SO2 = airQualityData['data']['forecast']['daily']['so2'][3]['avg'];
      } catch (e) {
        SO2 = '0';
      }
    }
    try {
      PM10 = airQualityData['data']['iaqi']['pm10']['v'];
    } catch (e) {
      try {
        PM10 = airQualityData['data']['forecast']['daily']['pm10'][3]['avg'];
      } catch (e) {
        PM10 = '0';
      }
    }
    try {
      PM2_5 = airQualityData['data']['iaqi']['pm25']['v'];
    } catch (e) {
      try {
        PM2_5 = airQualityData['data']['forecast']['daily']['pm25'][3]['avg'];
      } catch (e) {
        PM2_5 = '0';
      }
    }

    listColorAndDescription = weather.getAirQualityIndexColor(widget.airQualityIndex);
  }
}
