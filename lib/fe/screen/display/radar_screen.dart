import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:weather_mobile_app_flutter/be/state_management/Manager.dart';
import 'package:weather_mobile_app_flutter/configs/utils.dart';

import '../../../configs/constants.dart';

class Radar extends StatefulWidget {
  @override
  State<Radar> createState() => _Radar();
}

class _Radar extends State<Radar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WeatherMap(),
        SelectionMap(),
      ],
    );
  }
}

class WeatherMap extends StatelessWidget {
  final String apiKey = Constants.apiKeyOpenWeatherMap;

  @override
  Widget build(BuildContext context) {
    var map = Provider.of<MapManager>(context);
    return FlutterMap(
      options: MapOptions(
        center: LatLng(21.0285, 105.8542), // Vị trí ban đầu, ví dụ: Hà Nội
        zoom: 6.0,
      ),
      children: [
        Opacity(
          opacity: 0.7,
          child: TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: TileLayer(
            urlTemplate:
                'https://tile.openweathermap.org/map/{layer}/{z}/{x}/{y}.png?appid={apiKey}',
            additionalOptions: {
              'layer': map.type,
              'apiKey': apiKey,
            },
          ),
        ),
      ],
    );
  }
}

class SelectionMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var map = Provider.of<MapManager>(context);
    return Positioned(
      top: 50,
      right: 25,
      child: PopupMenuButton<String>(
        onSelected: (String value) {
          map.updateMap(value);
        },
        itemBuilder: (BuildContext context) {
          return [
            const PopupMenuItem<String>(
              value: 'clouds_new',
              child: Text('cloud'),
            ),
            const PopupMenuItem<String>(
              value: 'precipitation_new',
              child: Text('precipitation'),
            ),
            const PopupMenuItem<String>(
              value: 'pressure_new',
              child: Text('pressure'),
            ),
            const PopupMenuItem<String>(
              value: 'wind_new',
              child: Text('wind'),
            ),
            const PopupMenuItem<String>(
              value: 'temp_new',
              child: Text('temperature'),
            ),
          ];
        },
        child: Container(
          padding: EdgeInsets.all(8),
          child: Text(Utils.getNameMap(map.type)),
          decoration: BoxDecoration(
            color: MyColors.WHITE,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
