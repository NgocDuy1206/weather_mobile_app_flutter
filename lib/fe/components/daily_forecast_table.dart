import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:weather_mobile_app_flutter/be/data/weather_by_day.dart';
import 'package:weather_mobile_app_flutter/be/state_management/Manager.dart';
import 'package:weather_mobile_app_flutter/be/state_management/setting_manager.dart';
import 'package:weather_mobile_app_flutter/configs/constants.dart';
import 'package:weather_mobile_app_flutter/configs/utils.dart';
import 'package:weather_mobile_app_flutter/fe/components/button_see_more.dart';

class DailyForecastTable extends StatelessWidget {
  bool showSeeMoreDetail;

  DailyForecastTable({this.showSeeMoreDetail = true});

  @override
  Widget build(BuildContext context) {
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
          DailyTable(showSeeMoreDetail: showSeeMoreDetail),
          if (showSeeMoreDetail == true) SeeMoreDetail(direction: 'daily_tab',),
        ],
      )),
    );
  }
}

class DailyTable extends StatelessWidget {
  bool showSeeMoreDetail;

  DailyTable({this.showSeeMoreDetail = true});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<WeatherManager>(context);
    int tempMax = provider.weatherLocation!.getTempMaxByDay().round();
    int tempMin = provider.weatherLocation!.getTempMinByDay().round();
    int distance = tempMax - tempMin;

    return Container(
      width: InforDevice.WIDTH - 80,
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: showSeeMoreDetail ? ((InforDevice.WIDTH - 20)/ 80).toInt() : 8,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: ColumnDailyForecast(
                index: index, min: tempMin, distance: distance),
          );
        },
      ),
    );
  }
}

class ColumnDailyForecast extends StatelessWidget {
  int index;
  int min;
  int distance;

  ColumnDailyForecast({this.index = 0, this.min = 0, this.distance = 10});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<WeatherManager>(context);
    WeatherByDay daily = provider.weatherLocation!.dayList[index];
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          Utils.getDay(daily.time),
          style: TextStyle(fontSize: 20),
        ),
        Text(
          Utils.getWeekDay(daily.time),
          style: TextStyle(fontSize: 20),
        ),
        Image.asset(
          MyIconWeather.getIconWeather(daily.icon, daily.time),
          scale: 2.75,
        ),
        DrawTemp(index: index, min: min, distance: distance),
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
              daily.precipitationProbability.toString() + '%',
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
    var set = Provider.of<SettingManager>(context);
    WeatherByDay daily = provider.weatherLocation!.dayList[index];
    return Container(
      color: MyColors.GREEN,
      height: 150,
      width: 40,
      child: Stack(
        children: [
          Positioned(
              left: 0,
              bottom: (daily.temperatureMin - min) / distance * 100,
              child: Column(children: [
                Text(Utils.getTemp(daily.temperatureMax, set.tempUnit)),
                Container(
                  width: 10,
                  height: (daily.temperatureMax - daily.temperatureMin) /
                      distance *
                      100,
                  child: Text('.'),
                  decoration: BoxDecoration(
                      color: MyColors.BLACK,
                      borderRadius: BorderRadius.circular(10)),
                ),
                Text(Utils.getTemp(daily.temperatureMin, set.tempUnit)),
              ])),
        ],
      ),
    );
  }
}
