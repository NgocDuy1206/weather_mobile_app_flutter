import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../components_health_center/advice.dart';
import '../../../components_health_center/air_quality_forecast.dart';
import '../../../components_health_center/air_quality_index.dart';
import '../../../components_health_center/data_history.dart';
import '../../../components_health_center/pollen.dart';
import '../../../components_health_center/pollutants.dart';



class HealthCenter extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Center'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.share)),
        ],
        backgroundColor: Colors.blue,

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AirQualityIndex(),
            SizedBox(height: 10,),
            Advice(),
            SizedBox(height: 10,),
            Pollutants(),
            SizedBox(height: 10,),

            // DataHistory(),
            // SizedBox(height: 10,),
            // Pollen(),
            // AirQualityForecast(),
          ],
        ),
      ),
    );
  }
}


