import 'package:flutter/cupertino.dart';
import 'package:weather_mobile_app_flutter/fe/components/hourly_forecast_table.dart';

class HourlyTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HourlyForecastTable(),
        SizedBox(height: 10,),
      ],
    );
  }
}