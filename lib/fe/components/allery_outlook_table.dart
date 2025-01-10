import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_mobile_app_flutter/fe/components/button_see_more.dart';

import '../../configs/constants.dart';

class AllergyOutlookTable extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (InforDevice.WIDTH - 40),

      margin: EdgeInsets.only(top: 10, bottom: 25),
      padding: EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: MyColors.background_table,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        children: [
          AllergyRateBar(factor: 'Grass'),
          Divider(thickness: 1,color: MyColors.WHITE,),
          AllergyRateBar(factor: 'Weed'),
          Divider(thickness: 1,color: MyColors.WHITE,),
          AllergyRateBar(factor: 'Tree'),
          SeeMoreDetail(direction: 'health_center',),
        ],
      ),
    );
  }
}

class AllergyRateBar extends StatelessWidget{
  String? factor;
  String? icon;
  
  AllergyRateBar({required this.factor});
  
  @override
  Widget build(BuildContext context) {
    if (factor == null) print('factor bị null');
    else {
      switch(factor) {
        case 'Grass': icon = 'assets/icon/grass.png';break;
        case 'Weed': icon = 'assets/icon/weed.png';break;
        case 'Tree': icon = 'assets/icon/tree.png';break;
        default: icon = 'assets/icon/grass.png';break;
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            flex: 1,
            child: Image.asset(icon!, scale: 1.5,)
        ),

        Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(factor! + 'pollen'),
                Text('None'),
              ],
            )
        )
      ],
    );
  }
}