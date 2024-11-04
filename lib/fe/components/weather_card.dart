import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_mobile_app_flutter/configs/constants.dart';


class WeatherCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Góc bo tròn
      ),
      child: Container(
        padding: EdgeInsets.all(3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // date
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('oct 26'),
                Text('sat'),
              ],
            ),
            Image.asset(
              'assets/icon/cloud.png',
              scale: 2.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('32', style: TextStyle(fontSize: 15),),
                    Text('/'),
                    Text('28', style: TextStyle(fontSize: 15),),
                  ],
                ),
                Text('Mostly cloudy'),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ImageIcon(
                      AssetImage('assets/icon/wind.png'),
                      size: 15,
                    ),
                    Text('NNE'),
                    SizedBox(
                      width: 10,
                    ),
                    Text('17 km/h'),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/icon/rainy_small.png',
                      scale: 4.0,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('67', style: TextStyle(fontSize: 13),),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ListWeatherCard extends StatelessWidget {
  int? cardCount;

  ListWeatherCard({this.cardCount = 1});

  @override
  Widget build(BuildContext context) {
    double line = cardCount! * 50;

    return Container(
      width: InforDevice.WIDTH - 20,
      height: line,
      child: ListView.builder(
        itemCount: cardCount!,
        itemBuilder: (BuildContext context, int index) {
          return WeatherCard();
        },
      ),
    );
  }
}
