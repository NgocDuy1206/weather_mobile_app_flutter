import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../../configs/constants.dart';

class Destination extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(left: 20),
          padding: EdgeInsets.all(10),
          width: 150,
          decoration: const BoxDecoration(
              color: MyColors.GRAY,
              borderRadius: BorderRadius.all(Radius.circular(19))
          ),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/icon/location_add.png'),
              Spacer(),
              Text('add location'),
            ],
          ),
        ),
      ],
    );
  }
}
