import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_mobile_app_flutter/be/data/weather_current.dart';
import 'package:weather_mobile_app_flutter/be/state_management/Manager.dart';


import '../../configs/constants.dart';
import '../../configs/utils.dart';

class CurrentDetailTable extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<WeatherManager>(context);
    WeatherCurrent now = provider.weatherLocation!.current;
    return Container(
      width: (InforDevice.WIDTH - 40),
      height: 284,
      margin: EdgeInsets.only(top: 10, bottom: 25),
      padding: EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: MyColors.GRAY,
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
              information: now.windSpeed.toString() + 'm/s'
          ),
          Divider(thickness: 1, color: MyColors.WHITE,),
          RowComponent(
              title: Utils.getText('humi'),
              information: now.humidity.toString() + '%'
          ),
          Divider(thickness: 1, color: MyColors.WHITE,),
          RowComponent(
              title: Utils.getText('visi'),
              information: now.visibility.toString() + 'km'
          ),
          Divider(thickness: 1, color: MyColors.WHITE,),
          RowComponent(
              title: Utils.getText('dew'),
              information: now.dewPoint.toString() + '${Constants.DEGREES}'
          ),
          Divider(thickness: 1, color: MyColors.WHITE,),
          RowComponent(
              title: Utils.getText('press'),
              information: now.pressure.toString() + 'kPa'
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
