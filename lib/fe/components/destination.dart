import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../configs/constants.dart';

class Destination extends StatelessWidget {
  String? destination;

  Destination({super.key, this.destination});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          // xu ly su kien tap
        },
        child: Container(
          margin: EdgeInsets.only(left: 3, right: 3),
          padding: EdgeInsets.all(10),
          decoration: const BoxDecoration(
              color: MyColors.GRAY,
              borderRadius: BorderRadius.all(Radius.circular(19))),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/icon/location_add.png'),
              SizedBox(width: 5),
              Text(destination!),
            ],
          ),
        ),
      ),
    );
  }
}

class ListDestination extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // giới hạn không gian
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal, // theo chiều ngang
        children: [
          Destination(
            destination: 'add location',
          ), //
          Destination(
            destination: 'hà nội',
          ),
          Destination(destination: 'nam định'),
          Destination(destination: 'thái bình'),
          Destination(destination: 'hải dương'),
          Destination(destination: 'quảng ninh'),
        ],
      ),
    );
  }
}
