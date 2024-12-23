import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_mobile_app_flutter/be/state_management/Manager.dart';


import '../../be/state_management/setting_manager.dart';
import '../../configs/constants.dart';
import '../../configs/utils.dart';

class WeatherDetail extends StatelessWidget {
  dynamic weather;
  String kind;

  WeatherDetail({this.weather, this.kind = 'hourly'});

  @override
  Widget build(BuildContext context) {
    dynamic provider = Provider
        .of<WeatherManager>(context)
        .weatherLocation;
    dynamic x = InforDevice.WIDTH;
    dynamic y = InforDevice.HEIGHT;
    return Container(
        padding: EdgeInsets.only(
          top: 10,
          left: 30,
          right: 30,
          bottom: 30,
        ),
        height: y * 1.5,
        width: x,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          color: Color(0xFF1EABD5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Time(),
            (kind == 'hourly') ? Text(Utils.getHourMinute(weather.time),
              style: TextStyle(fontSize: 30),) : SizedBox(height: 10,),
            Divider(thickness: 2,color: Color(0x66000000),),
            Expanded(flex: 1, child: WeatherIcon(weather: weather,)),
            Expanded(flex: 1, child: DetailTable(weather: weather, kind: kind,)),
          ],
        )
    );
  }
}

class WeatherIcon extends StatelessWidget {
  dynamic weather;
  WeatherIcon({this.weather});
  @override
  Widget build(BuildContext context) {
    var set = Provider.of<SettingManager>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          MyIconWeather.getIconWeather(weather.icon, weather.time),
          scale: 2.0,
        ),
        Text(Utils.getTemp(weather.temperature, set.tempUnit),
        style: TextStyle(fontSize: 35),),
      ],
    );
  }
}


class DetailTable extends StatelessWidget {
  dynamic weather;
  String kind;
  DetailTable({this.weather, this.kind = 'hourly'});

  @override
  Widget build(BuildContext context) {
    SettingManager set = Provider.of<SettingManager>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if(kind == 'hourly')
          OneRow(name: 'Feels Like', value: Utils.getTemp(weather.temperature, set.tempUnit),),
        if (kind == 'daily')
          OneRow(name: 'Temperature Max', value: Utils.getTemp(weather.temperatureMax, set.tempUnit),),
        if (kind == 'daily')
          OneRow(name: 'Temperature Min', value: Utils.getTemp(weather.temperatureMin, set.tempUnit),),

        OneRow(name: 'Wind Speed', value: Utils.getSpeed(weather.windSpeed, set.spdUnit),),

        OneRow(name: 'Wind Direction', value: weather.windDirection),

        OneRow(name: 'Precipitation Probability', value: weather.precipitationProbability.toString(),),


      ],
    );
  }
}

class Time extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    DateTime time = DateTime.now();
    String dayOfWeek = Utils.getWeekDay(time) + 'day, ';
    String month = Utils.getMonth2(time.month) + ' ' + time.day.toString();

    return Text(
      dayOfWeek + month,
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

class OneRow extends StatelessWidget {
  String name;
  String value;

  OneRow({this.name = 'Feels like', this.value = '0'});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name, style:  TextStyle(fontSize: 20),),
            Text(value, style: TextStyle(fontSize: 20),),
          ],
        ),
        Divider(thickness: 1,color: Color(0x66000000),),
      ],
    );
  }
}