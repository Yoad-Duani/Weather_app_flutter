import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:clima2/services/weather.dart';

const double intervalSfCartesianChartWidget = 10.0;
const int theNumbersOfDayToDisplay = 6;
const dayNameTextSevenDayForecast = TextStyle(color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.w500);
const dateTextSevenDayForecast = TextStyle(color: Colors.black);
const widthIconSevenDayForecast = 27.0;
const heightIconSevenDayForecast = 27.0;
const speedWindTextSevenDayForecast = TextStyle(color: Colors.black, fontSize: 10.0, fontWeight: FontWeight.w400);

extension Ex on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}

class SevenDayForecastScreen extends StatefulWidget {
  SevenDayForecastScreen({this.locationWeatherHourlyForecast});
  final locationWeatherHourlyForecast;
  @override
  _SevenDayForecastScreenState createState() => _SevenDayForecastScreenState();
}

class _SevenDayForecastScreenState extends State<SevenDayForecastScreen> {
  WeatherModel weather = WeatherModel();
  List<SevenDayForecast> chartDataMaxTemp = [];
  List<SevenDayForecast> chartDataMinTemp = [];
  List<String> dateStringList = [];
  List<String> iconNameList = [];
  List<String> iconNameListNight = [];
  List<double> speedWindList = [];
  int maxTempInThisWeek;
  int minTempInThisWeek;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeatherHourlyForecast);
    getMaxTempInThisWeek();
    getMinTempInThisWeek();
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
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Seven Day Forecast',
                  style: TextStyle(fontSize: 26, color: Colors.black),
                ),
                SizedBox(
                  height: 20.0,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    height: 500.0,
                    width: 500.0,
                    //
                    child: SfCartesianChart(
                      backgroundColor: Colors.white,
                      plotAreaBorderWidth: 0.0,
                      primaryYAxis: NumericAxis(
                        isVisible: false,
                        labelFormat: '{value}°',
                        interval: intervalSfCartesianChartWidget,
                        rangePadding: ChartRangePadding.additional,
                      ),
                      //
                      primaryXAxis: CategoryAxis(
                        isVisible: false,
                        plotBands: <PlotBand>[
                          PlotBand(
                            //Marks the day that today
                            isVisible: true,
                            start: -0.5,
                            end: 0.5,
                            color: Colors.grey[100],
                            opacity: 0.7,
                          ),
                        ],
                      ),
                      //
                      //
                      annotations: <CartesianChartAnnotation>[
                        //
                        //
                        ///Day 1 Top
                        CartesianChartAnnotation(
                          widget: TopSevenDayForecast(dayName: chartDataMaxTemp[0].day, date: dateStringList[0], iconName: iconNameList[0]),
                          coordinateUnit: CoordinateUnit.point,
                          region: AnnotationRegion.chart,
                          x: '${chartDataMaxTemp[0].day}',
                          y: (maxTempInThisWeek % intervalSfCartesianChartWidget == 0)
                              ? maxTempInThisWeek + intervalSfCartesianChartWidget - 4
                              : maxTempInThisWeek -
                                  (maxTempInThisWeek % intervalSfCartesianChartWidget) +
                                  intervalSfCartesianChartWidget +
                                  (intervalSfCartesianChartWidget - 5),
                        ),
                        //
                        ///Day 2 Top
                        CartesianChartAnnotation(
                          widget: TopSevenDayForecast(dayName: chartDataMaxTemp[1].day, date: dateStringList[1], iconName: iconNameList[1]),
                          coordinateUnit: CoordinateUnit.point,
                          region: AnnotationRegion.chart,
                          x: '${chartDataMaxTemp[1].day}',
                          y: (maxTempInThisWeek % intervalSfCartesianChartWidget == 0)
                              ? maxTempInThisWeek + intervalSfCartesianChartWidget - 4
                              : maxTempInThisWeek -
                                  (maxTempInThisWeek % intervalSfCartesianChartWidget) +
                                  intervalSfCartesianChartWidget +
                                  (intervalSfCartesianChartWidget - 5),
                        ),
                        //
                        ///Day 3 Top
                        CartesianChartAnnotation(
                          widget: TopSevenDayForecast(dayName: chartDataMaxTemp[2].day, date: dateStringList[2], iconName: iconNameList[2]),
                          coordinateUnit: CoordinateUnit.point,
                          region: AnnotationRegion.chart,
                          x: '${chartDataMaxTemp[2].day}',
                          y: (maxTempInThisWeek % intervalSfCartesianChartWidget == 0)
                              ? maxTempInThisWeek + intervalSfCartesianChartWidget - 4
                              : maxTempInThisWeek -
                                  (maxTempInThisWeek % intervalSfCartesianChartWidget) +
                                  intervalSfCartesianChartWidget +
                                  (intervalSfCartesianChartWidget - 5),
                        ),
                        //
                        ///Day 4 Top
                        CartesianChartAnnotation(
                          widget: TopSevenDayForecast(dayName: chartDataMaxTemp[3].day, date: dateStringList[3], iconName: iconNameList[3]),
                          coordinateUnit: CoordinateUnit.point,
                          region: AnnotationRegion.chart,
                          x: '${chartDataMaxTemp[3].day}',
                          y: (maxTempInThisWeek % intervalSfCartesianChartWidget == 0)
                              ? maxTempInThisWeek + intervalSfCartesianChartWidget - 4
                              : maxTempInThisWeek -
                                  (maxTempInThisWeek % intervalSfCartesianChartWidget) +
                                  intervalSfCartesianChartWidget +
                                  (intervalSfCartesianChartWidget - 5),
                        ),
                        //
                        ///Day 5 Top
                        CartesianChartAnnotation(
                          widget: TopSevenDayForecast(dayName: chartDataMaxTemp[4].day, date: dateStringList[4], iconName: iconNameList[4]),
                          coordinateUnit: CoordinateUnit.point,
                          region: AnnotationRegion.chart,
                          x: '${chartDataMaxTemp[4].day}',
                          y: (maxTempInThisWeek % intervalSfCartesianChartWidget == 0)
                              ? maxTempInThisWeek + intervalSfCartesianChartWidget - 4
                              : maxTempInThisWeek -
                                  (maxTempInThisWeek % intervalSfCartesianChartWidget) +
                                  intervalSfCartesianChartWidget +
                                  (intervalSfCartesianChartWidget - 5),
                        ),
                        //
                        ///Day 6 Top
                        CartesianChartAnnotation(
                          widget: TopSevenDayForecast(dayName: chartDataMaxTemp[5].day, date: dateStringList[5], iconName: iconNameList[5]),
                          coordinateUnit: CoordinateUnit.point,
                          region: AnnotationRegion.chart,
                          x: '${chartDataMaxTemp[5].day}',
                          y: (maxTempInThisWeek % intervalSfCartesianChartWidget == 0)
                              ? maxTempInThisWeek + intervalSfCartesianChartWidget - 4
                              : maxTempInThisWeek -
                                  (maxTempInThisWeek % intervalSfCartesianChartWidget) +
                                  intervalSfCartesianChartWidget +
                                  (intervalSfCartesianChartWidget - 5),
                        ),
                        //
                        ///Day 7 Top
                        CartesianChartAnnotation(
                          widget: TopSevenDayForecast(dayName: chartDataMaxTemp[6].day, date: dateStringList[6], iconName: iconNameList[6]),
                          coordinateUnit: CoordinateUnit.point,
                          region: AnnotationRegion.chart,
                          x: '${chartDataMaxTemp[6].day}',
                          y: (maxTempInThisWeek % intervalSfCartesianChartWidget == 0)
                              ? maxTempInThisWeek + intervalSfCartesianChartWidget - 4
                              : maxTempInThisWeek -
                                  (maxTempInThisWeek % intervalSfCartesianChartWidget) +
                                  intervalSfCartesianChartWidget +
                                  (intervalSfCartesianChartWidget - 5),
                        ),
                        //
                        //
                        //
                        //
                        ///Night 1 Bottom
                        CartesianChartAnnotation(
                          widget: BottomSevenDayForecast(iconNameListNight: iconNameListNight[0], speedWindList: speedWindList[0]),
                          coordinateUnit: CoordinateUnit.point,
                          region: AnnotationRegion.chart,
                          x: '${chartDataMaxTemp[0].day}',
                          y: (minTempInThisWeek % intervalSfCartesianChartWidget == 0)
                              ? minTempInThisWeek - 5
                              : minTempInThisWeek - (minTempInThisWeek % intervalSfCartesianChartWidget) - 5,
                        ),
                        //
                        ///Night 2 Bottom
                        CartesianChartAnnotation(
                          widget: BottomSevenDayForecast(iconNameListNight: iconNameListNight[1], speedWindList: speedWindList[1]),
                          coordinateUnit: CoordinateUnit.point,
                          region: AnnotationRegion.chart,
                          x: '${chartDataMaxTemp[1].day}',
                          y: (minTempInThisWeek % intervalSfCartesianChartWidget == 0)
                              ? minTempInThisWeek - 5
                              : minTempInThisWeek - (minTempInThisWeek % intervalSfCartesianChartWidget) - 5,
                        ),
                        //
                        ///Night 3 Bottom
                        CartesianChartAnnotation(
                          widget: BottomSevenDayForecast(iconNameListNight: iconNameListNight[2], speedWindList: speedWindList[2]),
                          coordinateUnit: CoordinateUnit.point,
                          region: AnnotationRegion.chart,
                          x: '${chartDataMaxTemp[2].day}',
                          y: (minTempInThisWeek % intervalSfCartesianChartWidget == 0)
                              ? minTempInThisWeek - 5
                              : minTempInThisWeek - (minTempInThisWeek % intervalSfCartesianChartWidget) - 5,
                        ),
                        //
                        ///Night 4 Bottom
                        CartesianChartAnnotation(
                          widget: BottomSevenDayForecast(iconNameListNight: iconNameListNight[3], speedWindList: speedWindList[3]),
                          coordinateUnit: CoordinateUnit.point,
                          region: AnnotationRegion.chart,
                          x: '${chartDataMaxTemp[3].day}',
                          y: (minTempInThisWeek % intervalSfCartesianChartWidget == 0)
                              ? minTempInThisWeek - 5
                              : minTempInThisWeek - (minTempInThisWeek % intervalSfCartesianChartWidget) - 5,
                        ),
                        //
                        ///Night 5 Bottom
                        CartesianChartAnnotation(
                          widget: BottomSevenDayForecast(iconNameListNight: iconNameListNight[4], speedWindList: speedWindList[4]),
                          coordinateUnit: CoordinateUnit.point,
                          region: AnnotationRegion.chart,
                          x: '${chartDataMaxTemp[4].day}',
                          y: (minTempInThisWeek % intervalSfCartesianChartWidget == 0)
                              ? minTempInThisWeek - 5
                              : minTempInThisWeek - (minTempInThisWeek % intervalSfCartesianChartWidget) - 5,
                        ),
                        //
                        ///Night 6 Bottom
                        CartesianChartAnnotation(
                          widget: BottomSevenDayForecast(iconNameListNight: iconNameListNight[5], speedWindList: speedWindList[5]),
                          coordinateUnit: CoordinateUnit.point,
                          region: AnnotationRegion.chart,
                          x: '${chartDataMaxTemp[5].day}',
                          y: (minTempInThisWeek % intervalSfCartesianChartWidget == 0)
                              ? minTempInThisWeek - 5
                              : minTempInThisWeek - (minTempInThisWeek % intervalSfCartesianChartWidget) - 5,
                        ),
                        //
                        ///Night 7 Bottom
                        CartesianChartAnnotation(
                          widget: BottomSevenDayForecast(iconNameListNight: iconNameListNight[6], speedWindList: speedWindList[6]),
                          coordinateUnit: CoordinateUnit.point,
                          region: AnnotationRegion.chart,
                          x: '${chartDataMaxTemp[6].day}',
                          y: (minTempInThisWeek % intervalSfCartesianChartWidget == 0)
                              ? minTempInThisWeek - 5
                              : minTempInThisWeek - (minTempInThisWeek % intervalSfCartesianChartWidget) - 5,
                        ),
                      ],
                      //
                      //
                      ///Max Temp Line Series
                      series: <ChartSeries>[
                        LineSeries<SevenDayForecast, String>(
                          dataSource: chartDataMaxTemp,
                          xValueMapper: (SevenDayForecast sales, _) => sales.day,
                          yValueMapper: (SevenDayForecast sales, _) => sales.temp,
                          color: Colors.grey[400],
                          markerSettings: MarkerSettings(
                            isVisible: true,
                            color: Colors.white,
                            height: 6.0,
                            width: 6.0,
                          ),
                          dataLabelSettings: DataLabelSettings(
                            isVisible: true,
                            labelAlignment: ChartDataLabelAlignment.top,
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                        //
                        //
                        ///Max Temp Line Series
                        LineSeries<SevenDayForecast, String>(
                          dataSource: chartDataMinTemp,
                          xValueMapper: (SevenDayForecast sales, _) => sales.day,
                          yValueMapper: (SevenDayForecast sales, _) => sales.temp,
                          color: Colors.grey[400],
                          markerSettings: MarkerSettings(
                            isVisible: true,
                            color: Colors.white,
                            height: 6.0,
                            width: 6.0,
                          ),
                          dataLabelSettings: DataLabelSettings(
                            isVisible: true,
                            labelPosition: ChartDataLabelPosition.inside,
                            labelAlignment: ChartDataLabelAlignment.bottom,
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
  ///update and get all the data That should be show
  void updateUI(dynamic locationWeatherHourlyForecast) {
    chartDataMaxTemp = [];
    chartDataMinTemp = [];
    dateStringList = [];
    iconNameList = [];
    iconNameListNight = [];
    speedWindList = [];

    var dayName;
    var maxTemp;
    var minTemp;
    var dateString;
    double speedWind;
    var formatDayName = new DateFormat('EEEE');
    var formatDate = new DateFormat('M/d');

    for (var i = 0; i <= theNumbersOfDayToDisplay; i++) {
      var myAPIEpochTimeInMilliseconds = (locationWeatherHourlyForecast['daily'][i]['dt']) + locationWeatherHourlyForecast['timezone_offset'];
      DateTime date = new DateTime.fromMillisecondsSinceEpoch(myAPIEpochTimeInMilliseconds * 1000).toUtc();
      dayName = formatDayName.format(date);
      dateString = formatDate.format(date);

      var tempMAX = locationWeatherHourlyForecast['daily'][i]['temp']['max'];
      maxTemp = tempMAX.toInt();

      var tempMIN = locationWeatherHourlyForecast['daily'][i]['temp']['min'];
      minTemp = tempMIN.toInt();

      speedWind = (locationWeatherHourlyForecast['hourly'][i]['wind_speed']) * 3.6;
      speedWind = speedWind.toPrecision(1);

      chartDataMaxTemp.add(SevenDayForecast("$dayName", maxTemp));
      chartDataMinTemp.add(SevenDayForecast("$dayName", minTemp));
      iconNameList.add(weather.getWeatherIconPNG(locationWeatherHourlyForecast['daily'][i]['weather'][0]['icon']));
      iconNameListNight.add(weather.getWeatherIconPNGonlyNight(locationWeatherHourlyForecast['daily'][i]['weather'][0]['icon']));
      dateStringList.add(dateString);
      speedWindList.add(speedWind);
    }
  }

  //
  //
  ///Get the highest temperature in this week - Used to place the TopSevenDayForecast on axis Y
  void getMaxTempInThisWeek() {
    maxTempInThisWeek = -999;
    for (var i = 0; i <= chartDataMaxTemp.length - 1; i++) {
      if (chartDataMaxTemp[i].temp > maxTempInThisWeek) {
        maxTempInThisWeek = chartDataMaxTemp[i].temp;
      }
    }
  }

  //
  //
  ///Get the lowest temperature in this week - Used to place the BottomSevenDayForecast on axis Y
  void getMinTempInThisWeek() {
    minTempInThisWeek = 999;
    for (var i = 0; i <= chartDataMinTemp.length - 1; i++) {
      if (chartDataMinTemp[i].temp < minTempInThisWeek) {
        minTempInThisWeek = chartDataMinTemp[i].temp;
      }
    }
  }
}

//
//
//
///Custom widget for bottom (night icon and speed wind)
class BottomSevenDayForecast extends StatelessWidget {
  const BottomSevenDayForecast({
    @required this.iconNameListNight,
    @required this.speedWindList,
  });

  final String iconNameListNight;
  final double speedWindList;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          Image.asset(
            'images/$iconNameListNight.png',
            height: heightIconSevenDayForecast,
            width: widthIconSevenDayForecast,
          ),
          SizedBox(
            height: 18,
          ),
          Text(
            '$speedWindList km/h',
            style: speedWindTextSevenDayForecast,
          ),
        ],
      ),
    );
  }
}

//
//
///Custom widget for top (day name , date , icon day)
class TopSevenDayForecast extends StatelessWidget {
  const TopSevenDayForecast({
    @required this.dayName,
    @required this.date,
    @required this.iconName,
  });

  final String dayName;
  final String date;
  final String iconName;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            dayName,
            style: dayNameTextSevenDayForecast,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            date,
            style: dateTextSevenDayForecast,
          ),
          SizedBox(
            height: 3,
          ),
          Image.asset(
            'images/$iconName.png',
            height: heightIconSevenDayForecast,
            width: widthIconSevenDayForecast,
          ),
        ],
      ),
    );
  }
}

//
///Object for list (max and min temp) the lists in use in the LineSeries
class SevenDayForecast {
  SevenDayForecast(this.day, this.temp);
  final String day;
  final int temp;
}
