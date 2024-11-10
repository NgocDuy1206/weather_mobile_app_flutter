import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SunMoon extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sun & Moon'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Container(
          child: Text('sun and moon'),
        ),
      ),
    );
  }
}