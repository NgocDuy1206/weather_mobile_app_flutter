import 'package:flutter/cupertino.dart';
import 'package:weather_mobile_app_flutter/configs/constants.dart';

import 'display_degrees.dart';

class WeatherNow extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: InforDevice.WIDTH,
      height: 200,

      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Degrees(degree: 50, size: 50,),
            const Text('Mostly cloud'),
          ],
        ),
      ),
    );
  }
}