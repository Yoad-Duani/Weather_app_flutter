import 'package:flutter/material.dart';
import 'package:clima2/utilities/constants.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:clima2/components/moreDetailsWeatherWidget.dart';

class SunriseAndSunsetWidget extends StatelessWidget {
  const SunriseAndSunsetWidget({
    @required this.hourDoubleNow,
    @required this.hourDoubleSunrise,
    @required this.hourDoubleSunset,
    @required this.hourStringSunset,
    @required this.hourStringSunrise,
    @required this.temperatureFeeLikes,
    @required this.humidityWeatherData,
    @required this.probabilityOfPrecipitation,
    @required this.pressure,
    @required this.speedWind,
    @required this.uvIndex,
  });

  final double hourDoubleNow;
  final double hourDoubleSunrise;
  final double hourDoubleSunset;
  final String hourStringSunrise;
  final String hourStringSunset;
  final int temperatureFeeLikes;
  final int humidityWeatherData;
  final int probabilityOfPrecipitation;
  final int pressure;
  final double speedWind;
  final double uvIndex;

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      // backgroundColor: Colors.red,
      axes: <RadialAxis>[
        RadialAxis(
          axisLineStyle: AxisLineStyle(
            dashArray: <double>[5, 5],
            thickness: 2,
            color: Colors.white.withOpacity(0.5),
          ),
          showTicks: false,
          showFirstLabel: true,
          showLastLabel: true,
          maximumLabels: 0,
          canScaleToFit: true,
          minimum: hourDoubleSunrise,
          maximum: hourDoubleSunset,
          radiusFactor: 1.3,
          startAngle: 230,
          endAngle: 310,
          onLabelCreated: axisLabelCreated,
          labelOffset: 0.12,
          offsetUnit: GaugeSizeUnit.factor,
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              angle: 90,
              axisValue: 180,
              positionFactor: 0.2,
              widget: MoreDetailsWeatherWidget(
                temperatureFeeLikes: temperatureFeeLikes,
                humidityWeatherData: humidityWeatherData,
                probabilityOfPrecipitation: probabilityOfPrecipitation,
                pressure: pressure,
                speedWind: speedWind,
                uvIndex: uvIndex,
              ),
            ),
          ],
          ranges: <GaugeRange>[],
          pointers: <GaugePointer>[
            RangePointer(
              value: hourDoubleNow,
              width: 2,
              color: Colors.white,
            ),
            MarkerPointer(
              value: hourDoubleNow,
              markerHeight: 21,
              markerWidth: 21,
              markerType: MarkerType.circle,
              color: Colors.yellow,
            ),
          ],
        ),
      ],
    );
  }

  ///style the labels
  void axisLabelCreated(AxisLabelCreatedArgs args) {
    if (args.text == hourDoubleSunrise.toString()) {
      args.labelStyle = GaugeTextStyle(
        color: Colors.white.withOpacity(0.8),
        fontSize: 11,
        fontWeight: FontWeight.w400,
      );
      args.canRotate = false;
      args.text = 'Sunrise $hourStringSunrise';
    }
    if (args.text == hourDoubleSunset.toString()) {
      args.labelStyle = GaugeTextStyle(
        color: Colors.white.withOpacity(0.8),
        fontSize: 11,
        fontWeight: FontWeight.w400,
      );
      args.canRotate = false;
      args.text = 'Sunset $hourStringSunset';
    }
  }
}
