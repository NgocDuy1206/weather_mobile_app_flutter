import 'package:flutter/cupertino.dart';
import 'package:weather_mobile_app_flutter/fe/components/display_percentage.dart';

import '../../configs/constants.dart';

class CurrentDetailTable extends StatelessWidget {
  List<String> infor = ['Precipitation', 'Wind', 'Humidity', 'Visibility', 'Dew point', 'Pressure'];
  @override
  Widget build(BuildContext context) {
    return Container(
      width: (InforDevice.WIDTH - 40),
      height: 220,
      margin: EdgeInsets.only(top: 10, bottom: 25),
      padding: EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: MyColors.GRAY,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.zero,
        itemCount: 6, itemBuilder: (BuildContext context, int index) {
          return RowCurrentDetail(title: infor[index]);
      },

      ),
    );
  }
}

class RowCurrentDetail extends StatelessWidget {
  String? title;
  RowCurrentDetail({required this.title});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title!, style: TextStyle(fontSize: 20),),
        Percentage(percent: 0, size: 20),
      ],
    );
  }
}