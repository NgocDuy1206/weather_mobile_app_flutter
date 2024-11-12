import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:weather_mobile_app_flutter/be/data/weather_current.dart';
import 'package:weather_mobile_app_flutter/be/state_management/Manager.dart';
import 'package:weather_mobile_app_flutter/configs/constants.dart';

import '../../be/state_management/setting_manager.dart';
import '../../configs/utils.dart';


class WeatherNow extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<WeatherManager>(context);
    var set = Provider.of<SettingManager>(context);
    WeatherCurrent now = provider.weatherLocation!.current;
    return Container(
      width: InforDevice.WIDTH,
      height: 200,

      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(Utils.getTemp(now.temperature, set.tempUnit),
              style: TextStyle(fontSize: 50),),
            Text(Utils.getText(now.weatherCode), style: TextStyle(fontSize: 20),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(Utils.getText('feel_like'), style: TextStyle(fontSize: 15),),
                Text(Utils.getTemp(now.temperatureApparent, set.tempUnit),
                  style: TextStyle(fontSize: 15),)
              ],
            )
          ],
        ),
      ),
    );
  }
}