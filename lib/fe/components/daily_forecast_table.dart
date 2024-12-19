import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_mobile_app_flutter/be/data/weather_by_day.dart';
import 'package:weather_mobile_app_flutter/be/state_management/Manager.dart';
import 'package:weather_mobile_app_flutter/be/state_management/setting_manager.dart';
import 'package:weather_mobile_app_flutter/configs/constants.dart';
import 'package:weather_mobile_app_flutter/configs/utils.dart';
import 'package:weather_mobile_app_flutter/fe/components/button_see_more.dart';
import 'package:weather_mobile_app_flutter/fe/components/weather_detail.dart';

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
        color: MyColors.background_table,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Center(
          child: Column(
        children: [
          DailyTable(showSeeMoreDetail: showSeeMoreDetail),
          if (showSeeMoreDetail == true)
            SeeMoreDetail(
              direction: 'daily_tab',
            ),
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
      height: 320,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount:
            showSeeMoreDetail ? ((InforDevice.WIDTH - 20) / 80).toInt() : 8,
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
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return WeatherDetail(kind: 'daily',weather: daily);
            }
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(
              color: MyColors.vien,
              width: 2
          ),
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  Utils.getDay(daily.time),
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(width: 5,),
                Text(
                  Utils.getWeekDay(daily.time),
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            Container(
              height: 1,
              width: 35,
              child: Divider(
                color: MyColors.vien,
                thickness: 1,
              ),
              margin: EdgeInsets.only(top: 3, bottom: 3),
            ),
            Image.asset(
              MyIconWeather.getIconWeather(daily.icon, daily.time),
              scale: 2.75,
            ),
            DrawTemp(index: index, min: min, distance: distance),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 1,
              width: 35,
              child: Divider(
                color: MyColors.vien,
                thickness: 1,
              ),
              margin: EdgeInsets.only(top: 3, bottom: 10),
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
        ),
      ),
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
      height: 160,
      width: 50,
      child: Stack(
        children: [
          Positioned(
              left: 0,
              bottom: (daily.temperatureMin - min) / distance * 100 ,
              child: Column(children: [
                Text(Utils.getTemp(daily.temperatureMax, set.tempUnit),
                style: TextStyle(
                  fontSize: 17,
                ),),
                Container(
                  width: 18,
                  height: (daily.temperatureMax - daily.temperatureMin) /
                      distance *
                      100 ,
                  child: Text('.'),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: MyColors.vien,
                      width: 2,
                    ),
                    gradient: LinearGradient(
                      colors: [
                        MyColors.beginColorColumn,
                        MyColors.endColorColumn
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
                Text(Utils.getTemp(daily.temperatureMin, set.tempUnit)),
              ])),
        ],
      ),
    );
  }
}
