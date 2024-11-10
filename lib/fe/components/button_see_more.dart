import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_mobile_app_flutter/configs/constants.dart';
import 'package:weather_mobile_app_flutter/fe/components/hourly_tab.dart';
import 'package:weather_mobile_app_flutter/fe/screen/display/expand/health_center.dart';
import 'package:weather_mobile_app_flutter/fe/screen/display/forecast_screen.dart';
import 'package:weather_mobile_app_flutter/be/state_management/Manager.dart';

import '../screen/display/expand/sun_moon.dart';

class SeeMoreDetail extends StatelessWidget {
  String direction;
  SeeMoreDetail({this.direction = 'hourly_tab'});
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomNagivation>(context);
    return ElevatedButton(
      onPressed: () {
        if (direction == 'hourly_tab') {
          provider.updateTab(1);
        } else if (direction == 'daily_tab') {
          provider.updateTab(1);
        } else if (direction == 'health_center') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => HealthCenter()));
        } else if (direction == 'sun_moon') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SunMoon()));
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: MyColors.BLUE,
        minimumSize: Size(InforDevice.WIDTH - 90, 50),
      ),
      child: const Text(
        'See More Detail',
        style: TextStyle(
          fontSize: 20,
          color: MyColors.WHITE,
        ),
      ),
    );
  }
}
