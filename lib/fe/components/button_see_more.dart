import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_mobile_app_flutter/configs/constants.dart';

class SeeMoreDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
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
