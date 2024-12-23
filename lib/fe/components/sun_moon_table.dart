import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_mobile_app_flutter/be/data/weather_by_day.dart';
import 'package:weather_mobile_app_flutter/be/state_management/Manager.dart';
import 'package:weather_mobile_app_flutter/configs/utils.dart';
import 'package:weather_mobile_app_flutter/fe/components/button_see_more.dart';

import '../../configs/constants.dart';

class SunMoonTable extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (InforDevice.WIDTH - 40),
      padding: EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: MyColors.background_table,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RiseAndSet(object: 'SUN'),
          SizedBox(height: 5,),
          Divider(thickness: 1,color: MyColors.WHITE,),
          SizedBox(height: 5,),
          RiseAndSet(object: 'MOON'),
          SizedBox(height: 5,),
          SeeMoreDetail(direction: 'sun_moon',),
        ],
      ),
    );
  }
}

class RiseAndSet extends StatelessWidget {
  String object ;
  String icon = 'assets/icon/sun.png';

  RiseAndSet({super.key, this.object = 'SUN'});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<WeatherManager>(context);
    WeatherByDay daily = provider.weatherLocation!.dayList[0];
    String timeRise = Utils.getHour12H(daily.sunrise);
    String timeSet = Utils.getHour12H(daily.sunset);
    if (object != 'SUN') {
      object = 'MOON';
      timeRise = Utils.getHour12H(daily.moonrise);
      timeSet = Utils.getHour12H(daily.moonset);
      icon = 'assets/icon/moon.png';
    }


    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 1, child: Container(height: 50,child: Image.asset(icon, scale: 1.15,))),
        Expanded(flex: 1, child: Time(name: object, kind: 'RISE', time: timeRise)),
        Expanded(flex: 1, child: Time(name: object, kind: 'SET', time: timeSet)),
      ],
    );
  }
}

class Time extends StatelessWidget {
  String name;
  String time;
  String kind;

  Time({this.name = 'SUN',  this.time = '0:00',  this.kind = 'RISE'});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name + kind,
          style: const TextStyle(
            fontSize: 15
          ),
        ),
        Text(
          time,
          style: const TextStyle(
            fontSize: 15
          ),
        )
      ],
    );
  }
}
