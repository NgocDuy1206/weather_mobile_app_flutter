import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_mobile_app_flutter/fe/components/button_see_more.dart';

import '../../configs/constants.dart';

class AirQualityTable extends StatelessWidget {
  String? airQuality;

  AirQualityTable({ this.airQuality = '90'});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (InforDevice.WIDTH - 40),


      margin: EdgeInsets.only(top: 10, bottom: 25),
      padding: EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: MyColors.GRAY,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DisplayAirQuality(airQuality: airQuality),
          SizedBox(height: 5,),
          Divider(thickness: 2, color: MyColors.WHITE,),
          SizedBox(height: 10,),
          AirQualityBar(),
          SizedBox(height: 10,),
          SeeMoreDetail(),
        ],
      ),
    );
  }
}

class AirQualityBar extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(flex: 1, child: Text('0'  , style: TextStyle(fontSize: 9),)),
            Expanded(flex: 1, child: Text('50' , style: TextStyle(fontSize: 9),)),
            Expanded(flex: 1, child: Text('100', style: TextStyle(fontSize: 9),)),
            Expanded(flex: 1, child: Text('150', style: TextStyle(fontSize: 9),)),
            Expanded(flex: 2, child: Text('200', style: TextStyle(fontSize: 9),)),
            Expanded(flex: 3, child: Text('300', style: TextStyle(fontSize: 9),)),
            Expanded(flex: 1, child: Text('500', style: TextStyle(fontSize: 9),)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(flex: 1, child: Container(height: 2, color: MyColors.GREEN,)),
            Expanded(flex: 1, child: Container(height: 2, color: MyColors.GREEN1,)),
            Expanded(flex: 1, child: Container(height: 2, color: MyColors.YELLOW1,)),
            Expanded(flex: 1, child: Container(height: 2, color: MyColors.YELLOW,)),
            Expanded(flex: 2, child: Container(height: 2, color: MyColors.RED1,)),
            Expanded(flex: 4, child: Container(height: 2, color: MyColors.RED,)),
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Good'),
            Text('Unhealthy'),
            Text('hazardous'),
          ],
        )
      ],
    );
  }
}

class DisplayAirQuality extends StatelessWidget{
  String? airQuality;

  DisplayAirQuality({required this.airQuality});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Text(airQuality!,
            style: TextStyle(fontSize: 50),),
        ),
        const Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Moderate',
                style: TextStyle(
                  fontSize:20,
                ),
              ),
              Text(
                  'Air quality between 51 and 100 is not ideal, so keep an eye on it',
                style: TextStyle(
                  fontSize: 15
                ),
              ),
            ],
          ),
        ),

      ],
    );
  }
}