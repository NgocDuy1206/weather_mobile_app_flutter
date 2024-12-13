import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_mobile_app_flutter/be/data/weather_current.dart';
import 'package:weather_mobile_app_flutter/be/state_management/Manager.dart';
import 'package:weather_mobile_app_flutter/be/state_management/setting_manager.dart';


import '../../configs/constants.dart';
import '../../configs/utils.dart';

class CurrentDetailTable extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<WeatherManager>(context);
    var set = Provider.of<SettingManager>(context);
    WeatherCurrent now = provider.weatherLocation!.current;
    return Container(
      width: (InforDevice.WIDTH - 40),
      height: 284,
      margin: EdgeInsets.only(top: 10, bottom: 25),
      padding: EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: MyColors.background_table,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        children: [
          RowComponent(
            title: Utils.getText('prep'),
            information: now.precipitation.toString() + '%'
          ),
          Divider(thickness: 1, color: MyColors.WHITE,),
          RowComponent(
              title: Utils.getText('wind'),
              information: Utils.getSpeed(now.windSpeed, set.spdUnit)
          ),
          Divider(thickness: 1, color: MyColors.WHITE,),
          RowComponent(
              title: Utils.getText('humi'),
              information: now.humidity.toString() + '%'
          ),
          Divider(thickness: 1, color: MyColors.WHITE,),
          RowComponent(
              title: Utils.getText('visi'),
              information: Utils.getDistance(now.visibility, set.distanceUnit)
          ),
          Divider(thickness: 1, color: MyColors.WHITE,),
          RowComponent(
              title: Utils.getText('dew'),
              information: Utils.getTemp(now.dewPoint, set.tempUnit)
          ),
          Divider(thickness: 1, color: MyColors.WHITE,),
          RowComponent(
              title: Utils.getText('press'),
              information: Utils.getPress(now.pressure, set.pressUnit)
          ),
        ],
      )
    );
  }
}

class RowComponent extends StatelessWidget {
  String title;
  String information;

  RowComponent({this.title = 'Precipitation', this.information = '20%'});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontSize: 20),),
        Text(information, style: TextStyle(fontSize: 20),)
      ],
    );
  }
}
