import 'package:flutter/cupertino.dart';
import 'package:weather_mobile_app_flutter/configs/constants.dart';
import 'package:weather_mobile_app_flutter/fe/components/button_see_more.dart';
import 'package:weather_mobile_app_flutter/fe/components/display_degrees.dart';
import 'package:weather_mobile_app_flutter/fe/components/display_percentage.dart';

class HourlyForecastTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: (InforDevice.WIDTH - 40),
      margin: EdgeInsets.only(top: 10, bottom: 25),
      padding: EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: MyColors.GRAY,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Center(
          child: Column(
        children: [
          HourlyTable(),
          SeeMoreDetail(),
        ],
      )),
    );
  }
}

class HourlyTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: InforDevice.WIDTH - 80,
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return ColumnHourlyForecast();
        },
      ),
    );
  }
}

class ColumnHourlyForecast extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          '15:00',
          style: TextStyle(fontSize: 20),
        ),
        Image.asset('assets/icon/sunny_and_cloud.png'),
        const SizedBox(
          height: 35,
        ),
        Degrees(degree: 24, size: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon/rainy_small.png',
              scale: 4.0,
            ),
            const SizedBox(
              width: 4,
            ),
            Percentage(percent: 0, size: 15),
          ],
        ),
      ],
    );
  }
}
