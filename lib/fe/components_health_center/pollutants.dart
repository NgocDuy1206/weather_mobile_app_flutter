import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_mobile_app_flutter/be/data/air_quality.dart';
import 'package:weather_mobile_app_flutter/be/state_management/Manager.dart';
import 'package:weather_mobile_app_flutter/configs/constants.dart';

import '../../configs/utils.dart';

class Pollutants extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      margin: EdgeInsets.only(top: 40, left: 10, right: 10),
      padding: EdgeInsets.only(top: 10, bottom: 20, left: 10, right: 10),
      decoration: BoxDecoration(
        color: MyColors.background_table,
        borderRadius: BorderRadius.circular(10),

      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('POLLUTANTS', style: TextStyle(fontWeight: FontWeight.w800),),
                Tooltip(
                    message: Utils.getText('information_pollutants'),
                    decoration: BoxDecoration(
                      color: MyColors.BLUE,
                    ),
                    child: Icon(Icons.info_outline_rounded)
                ),
              ],
            ),
          ),

          Row(
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    RowPollutant(factor: 'PM10'),
                    SizedBox(height: 10,),
                    RowPollutant(factor: 'CO',),
                    SizedBox(height: 10,),
                    RowPollutant(factor: 'SO2',),
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    width: 3,
                    height: 125,
                    alignment: Alignment.centerRight,
                    child:  VerticalDivider(thickness: 1, color: Colors.white,),
                  )
              ),
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    RowPollutant(factor: 'PM2.5',),
                    SizedBox(height: 10,),
                    RowPollutant(factor: 'O3',),
                    SizedBox(height: 10,),
                    RowPollutant(factor: 'NO2',),
                  ],
                ),
              )
            ],
          ),

        ],
      ),
    );
  }
}


class RowPollutant extends StatelessWidget {
  String factor;

  RowPollutant({this.factor =  'PM10'});
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<WeatherManager>(context);
    AirQuality aqi = provider.weatherLocation!.airQualityList[0];
    dynamic value = Utils.getValueAQI(factor, aqi);
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Container(
              height: 5,
              width: 5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Utils.getColorAQI(value),
              ),
            )
        ),
        Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(factor, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),),
                Text(Utils.getEvaluateAirQ(value),
                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.w400),),
              ],
            )
        ),
        Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(value.toStringAsFixed(0), style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),),
                Text(Utils.getUnitAQI(factor), style: TextStyle(fontSize: 9, fontWeight: FontWeight.w400),),
              ],
            )
        ),
      ],
    );
  }
}