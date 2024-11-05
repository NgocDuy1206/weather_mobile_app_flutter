import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_mobile_app_flutter/configs/constants.dart';
import 'package:weather_mobile_app_flutter/fe/components/hourly_tab.dart';
import 'package:weather_mobile_app_flutter/fe/screen/display/forecast_screen.dart';
import 'package:weather_mobile_app_flutter/be/state_management/Manager.dart';

class SeeMoreDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomNagivation>(context);
    return ElevatedButton(
      onPressed: () {
        provider.updateTab(1);
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
