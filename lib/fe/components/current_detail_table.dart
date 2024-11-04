import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:weather_mobile_app_flutter/be/data/weather_current.dart';
import 'package:weather_mobile_app_flutter/be/state_management/Manager.dart';


import '../../configs/constants.dart';

class CurrentDetailTable extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<WeatherManager>(context);
    WeatherCurrent now = provider.weatherLocation!.current;
    return Container(
      width: (InforDevice.WIDTH - 40),
      height: 220,
      margin: EdgeInsets.only(top: 10, bottom: 25),
      padding: EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: MyColors.GRAY,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        children: [
          RowComponent(
            title: 'Precipitation',
            information: now.precipitation.toString() + '%'
          ),
          RowComponent(
              title: 'Wind',
              information: now.windSpeed.toString() + 'm/s'
          ),
          RowComponent(
              title: 'Humidity',
              information: now.humidity.toString() + '%'
          ),
          RowComponent(
              title: 'Visibility',
              information: now.visibility.toString() + 'km'
          ),
          RowComponent(
              title: 'Dew point',
              information: now.dewPoint.toString() + '${Constants.DEGREES}'
          ),
          RowComponent(
              title: 'Pressure',
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
