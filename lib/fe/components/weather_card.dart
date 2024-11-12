import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_mobile_app_flutter/be/state_management/Manager.dart';
import 'package:weather_mobile_app_flutter/be/state_management/setting_manager.dart';
import 'package:weather_mobile_app_flutter/configs/constants.dart';
import 'package:weather_mobile_app_flutter/configs/utils.dart';

class WeatherCard extends StatelessWidget {
  int index;
  String kind;

  WeatherCard({this.kind = 'hourly', this.index = 0});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<WeatherManager>(context);
    dynamic card = (kind == 'hourly')
        ? provider.weatherLocation!.hourList[index]
        : provider.weatherLocation!.dayList[index];

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Góc bo tròn
      ),
      child: Container(
        height: 70,
        padding: EdgeInsets.all(3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // date
            Expanded(flex: 2,child: Column1(kind: kind, card: card,)),
            Expanded(flex: 1,child: Column2(card: card,)),
            Expanded(flex: 3,child: Column3(kind: kind,card: card,)),
            Expanded(flex: 3,child: Column4(card: card,)),
          ],
        ),
      ),
    );
  }
}

class Column1 extends StatelessWidget {
  String kind;
  dynamic card;

  Column1({this.kind = 'hourly', this.card});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        (kind == 'hourly')
            ? Text(Utils.getHourMinute(card.time))
            : Text(Utils.getMonthDay(card.time)),
        (kind == 'hourly')
            ? Text(Utils.getMonthDay(card.time))
            : Text(Utils.getWeekDay(card.time)),
      ],
    );
  }
}

class Column2 extends StatelessWidget {
  dynamic card;
  Column2({this.card});
  @override
  Widget build(BuildContext context) {
    return
      Image.asset(
        MyIconWeather.getIconWeather(card.icon, card.time),
        scale: 3.0,
      );
  }
}

class Column3 extends StatelessWidget {
  String kind;
  dynamic card;

  Column3({this.kind = 'hourly', this.card});
  @override
  Widget build(BuildContext context) {
    var set = Provider.of<SettingManager>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            (kind == 'hourly')
                ? Text(
              Utils.getTemp(card.temperature, set.tempUnit),
              style: TextStyle(fontSize: 15),
            )
                : Text(
              Utils.getTemp(card.temperatureMax, set.tempUnit),
              style: TextStyle(fontSize: 15),
            ),
            (kind == 'hourly') ? Text(Utils.getText('feel_like'),style: TextStyle(fontSize: 10),)
                : Text(' / ', style: TextStyle(fontSize: 10),),
            (kind == 'hourly')
                ? Text(
              Utils.getTemp(card.temperatureApparent, set.tempUnit),
              style: TextStyle(fontSize: 10),
            )
                : Text(
              Utils.getTemp(card.temperatureMin, set.tempUnit),
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
        Text(Utils.getText(card.weatherCode), style: TextStyle(fontSize: 13),),
      ],
    );
  }
}

class Column4 extends StatelessWidget {
  dynamic card;
  Column4({this.card});
  @override
  Widget build(BuildContext context) {
    var set = Provider.of<SettingManager>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const ImageIcon(
              AssetImage('assets/icon/wind.png'),
              size: 15,
            ),
            Text(card.windDirection, style: TextStyle(fontSize: 12),),
            const SizedBox(
              width: 10,
            ),
            Text(Utils.getSpeed(card.windSpeed, set.spdUnit), style: TextStyle(fontSize: 12),),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              'assets/icon/rainy_small.png',
              scale: 4.0,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              card.precipitationProbability.toString() + '%',
              style: TextStyle(fontSize: 13),
            ),
          ],
        )
      ],
    );
  }
}
