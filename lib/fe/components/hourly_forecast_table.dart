import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_mobile_app_flutter/be/data/weather_by_hour.dart';
import 'package:weather_mobile_app_flutter/be/state_management/Manager.dart';
import 'package:weather_mobile_app_flutter/be/state_management/setting_manager.dart';
import 'package:weather_mobile_app_flutter/configs/constants.dart';
import 'package:weather_mobile_app_flutter/configs/utils.dart';
import 'package:weather_mobile_app_flutter/fe/components/button_see_more.dart';

class HourlyForecastTable extends StatelessWidget {
  bool showSeeMoreDetail;

  HourlyForecastTable({this.showSeeMoreDetail = true});

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
      height: 280,
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
    return Container(
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
          Text(
            Utils.getHourMinute(hourWeather.time),
            style: TextStyle(fontSize: 18),
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
            MyIconWeather.getIconWeather(hourWeather.icon, hourWeather.time),
            scale: 2.75,
          ),
          DrawTemp(
            index: index,
            min: min,
            distance: distance,
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
                hourWeather.precipitationProbability.toString() + '%',
                style: TextStyle(fontSize: 15),
              ),
            ],
          ),
        ],
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
    WeatherByHour hourly = provider.weatherLocation!.hourList[index];
    return Container(

      height: 130,
      width: 50,
      child: Stack(
        children: [
          Positioned(
              left: 0,
              bottom: (hourly.temperature - min) / distance * 90,
              child: Column(children: [
                Text(
                    Utils.getTemp(hourly.temperature, set.tempUnit),
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                Center(
                  child: Container(
                    height: 18,
                    width: 18,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: MyColors.vien,
                          width: 2,
                        ),
                        gradient: LinearGradient(
                            colors: [MyColors.beginColorColumn, MyColors.endColorColumn],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ])),
        ],
      ),
    );
  }
}
