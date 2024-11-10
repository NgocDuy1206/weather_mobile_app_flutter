import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_mobile_app_flutter/configs/constants.dart';

class Pollutants extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      margin: EdgeInsets.only(top: 40, left: 10, right: 10),
      padding: EdgeInsets.only(top: 10, bottom: 20, left: 10, right: 10),
      decoration: BoxDecoration(
        color: MyColors.GRAY,
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
                Icon(Icons.info_outline_rounded),
              ],
            ),
          ),

          Row(
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    RowPollutant(),
                    SizedBox(height: 10,),
                    RowPollutant(),
                    SizedBox(height: 10,),
                    RowPollutant(),
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
                    RowPollutant(),
                    SizedBox(height: 10,),
                    RowPollutant(),
                    SizedBox(height: 10,),
                    RowPollutant(),
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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Container(
              height: 5,
              width: 5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
              ),
            )
        ),
        Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('PM10', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),),
                Text('Unhealthy', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),),
              ],
            )
        ),
        Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('190', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),),
                Text('g/m3', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),),
              ],
            )
        ),
      ],
    );
  }
}