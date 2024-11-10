import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:weather_mobile_app_flutter/be/data/weather_by_hour.dart';
import 'package:weather_mobile_app_flutter/be/state_management/Manager.dart';
import 'package:weather_mobile_app_flutter/configs/constants.dart';
import 'package:weather_mobile_app_flutter/configs/utils.dart';
import 'package:weather_mobile_app_flutter/fe/components/button_see_more.dart';

class HourlyForecastTable extends StatelessWidget {
  bool showSeeMoreDetail;

  HourlyForecastTable({this.showSeeMoreDetail = true});

  @override
  Widget build(BuildContext context) {
    print(InforDevice.WIDTH);
    return Container(
      width: (InforDevice.WIDTH - 40),
      margin: EdgeInsets.only(top: 10, bottom: 25, left: 10, right: 10),
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 2, right: 2),
      decoration: const BoxDecoration(
        color: MyColors.GRAY,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Center(
          child: Column(
        children: [
          HourlyTable(showSeeMoreDetail: showSeeMoreDetail),
          if (showSeeMoreDetail == true) SeeMoreDetail(direction: 'hourly_tab',),
        ],
      )),
    );
  }
}

class HourlyTable extends StatelessWidget {
  bool showSeeMoreDetail;

  HourlyTable({this.showSeeMoreDetail = true});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<WeatherManager>(context);
    int tempMax = provider.weatherLocation!.getTempMaxByHour().round();
    int tempMin = provider.weatherLocation!.getTempMinByHour().round();
    int distance = tempMax - tempMin;
    return Container(
      width: InforDevice.WIDTH - 80,
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: showSeeMoreDetail ? ((InforDevice.WIDTH - 20)/ 80).toInt() : 24,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ColumnHourlyForecast(
                index: index,
                min: tempMin,
                distance: distance,
              ));
        },
      ),
    );
  }
}

class ColumnHourlyForecast extends StatelessWidget {
  int index;
  int min;
  int distance;

  ColumnHourlyForecast({this.index = 0, this.min = 0, this.distance = 10});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<WeatherManager>(context);
    WeatherByHour hourWeather = provider.weatherLocation!.hourList[index];
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          Utils.getHourMinute(hourWeather.time),
          style: TextStyle(fontSize: 20),
        ),
        Image.asset(
          MyIconWeather.getIconWeather(hourWeather.icon, hourWeather.time),
          scale: 2.75,
        ),
        DrawTemp(
          index: index,
          min: min,
          distance: distance,
        ),
        SizedBox(
          height: 3,
        ),
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
            Text(
              hourWeather.precipitationProbability.toString() + '%',
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ],
    );
  }
}

class DrawTemp extends StatelessWidget {
  int index;
  int min;
  int distance;

  DrawTemp({this.index = 0, this.min = 0, this.distance = 10});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<WeatherManager>(context);
    WeatherByHour hourly = provider.weatherLocation!.hourList[index];
    return Container(
      color: MyColors.GREEN,
      height: 120,
      width: 40,
      child: Stack(
        children: [
          Positioned(
              left: 0,
              bottom: (hourly.temperature - min) / distance * 90,
              child: Column(children: [
                Text(hourly.temperature.toString() + '${Constants.DEGREES}'),
                Center(
                  child: Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                        color: MyColors.BLACK,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ])),
        ],
      ),
    );
  }
}
