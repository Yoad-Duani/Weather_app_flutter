import 'package:flutter/material.dart';
import 'package:clima2/screens/airQuality_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AirQualityWidget extends StatelessWidget {
  const AirQualityWidget({
    @required this.airQualityIndex,
    @required this.cityName,
    @required this.airData,
    @required this.hourTime,
  });

  final int airQualityIndex;
  final String cityName;
  final dynamic airData;
  final String hourTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 18,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Air Quality Index',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    '$airQualityIndex',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    width: 3.0,
                  ),
                  Icon(
                    FontAwesomeIcons.leaf,
                    color: Colors.white,
                  ),
                ],
              ),
              InkWell(
                  child: Text(
                    'Full data air quality',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 14.0,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return AirQualityScreen(
                        cityName: cityName,
                        airQualityIndex: airQualityIndex,
                        airData: airData,
                        hourTime: hourTime,
                      );
                    }));
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
