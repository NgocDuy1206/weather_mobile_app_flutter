import 'package:flutter/cupertino.dart';

class Forecast extends StatefulWidget {

  @override
  State<Forecast> createState() => _Forecast();
}

class _Forecast extends State<Forecast>{
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('this is forecast screen'));
  }
}