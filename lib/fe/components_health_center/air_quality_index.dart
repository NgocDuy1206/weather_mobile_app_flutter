import 'package:flutter/cupertino.dart';
import 'package:weather_mobile_app_flutter/configs/constants.dart';
import 'package:weather_mobile_app_flutter/fe/components_health_center/draw_aqi_index.dart';

class AirQualityIndex extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      margin: EdgeInsets.only(top: 40, left: 10, right: 10),
      padding: EdgeInsets.only(top: 10, bottom: 20, left: 10, right: 10),
      decoration: BoxDecoration(
        color: MyColors.background_table,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex: 1,child: Left()),
          Expanded(flex: 1,child: Right()),
        ],
      ),
    );
  }
}

class Left extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'AIR QUALITY INDEX',
          style: TextStyle(fontSize: 20),
        ),
        DrawAqiIndex(),
        Text(
          'Unhealthy',
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}

class Right extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
