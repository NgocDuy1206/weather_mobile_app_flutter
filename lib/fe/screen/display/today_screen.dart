import 'package:flutter/material.dart';

import '../../../configs/constants.dart';
import '../../components/air_quality_table.dart';
import '../../components/allery_outlook_table.dart';
import '../../components/current_detail_table.dart';
import '../../components/daily_forecast_table.dart';
import '../../components/destination.dart';
import '../../components/hourly_forecast_table.dart';
import '../../components/sun_moon_table.dart';
import '../../components/weather_now.dart';

class Today extends StatefulWidget {
  const Today({super.key});

  @override
  State<Today> createState() => _TodayState();
}

class _TodayState extends State<Today> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset('assets/image/background.jpg',),
      CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text(
              Constants.NAME_APP,
              style: TextStyle(
                color: MyColors.WHITE,
              ),
            ),
            floating: true,
            pinned: false,
            backgroundColor: Colors.transparent,
            snap: true,
            expandedHeight: 200,
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Image.asset('assets/icon/search.png')),
              IconButton(
                onPressed: () {},
                icon: Image.asset('assets/icon/menu.png'),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                ListDestination(),

                WeatherNow(),

                Container(
                  child: Column(
                    children: [
                      Text('Hourly Forecast'),
                      HourlyForecastTable(),
                      Text('Current Detail'),
                      CurrentDetailTable(),
                      Text('Daily Forecast'),
                      DailyForecastTable(),
                      Text('Air Quality'),
                      AirQualityTable(),
                      Text('Allergy Outlook'),
                      AlleryOutlookTable(),
                      Text('Sun & Moon'),
                      SunMoonTable(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      
    ]);
  }
}
