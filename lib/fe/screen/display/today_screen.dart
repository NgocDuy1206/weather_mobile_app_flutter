import 'package:flutter/material.dart';
import 'package:weather_mobile_app_flutter/fe/screen/setting/DaoScreen/setting_screen.dart';

import '../../../configs/constants.dart';
import '../../components/air_quality_table.dart';
import '../../components/allery_outlook_table.dart';
import '../../components/current_detail_table.dart';
import '../../components/daily_forecast_table.dart';
import '../../components/destination.dart';
import '../../components/hourly_forecast_table.dart';
import '../../components/sun_moon_table.dart';
import '../../components/weather_now.dart';
import '../display_search_manageLocation/search_screen.dart';

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
            expandedHeight: 110,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                children: [
                  SizedBox(height: 90),
                  ListDestination(),
                ],
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SearchScreenModal()));
                  },
                  icon: Image.asset('assets/icon/search.png')),
              IconButton(
                onPressed: () {
                  Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingScreen()));
                },
                icon: Image.asset('assets/icon/menu.png'),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [

                WeatherNow(),

                Container(
                  width: InforDevice.WIDTH,
                  padding: EdgeInsets.only(top: 25, bottom: 10),
                  decoration: const BoxDecoration(
                    color: MyColors.WHITE,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      const Text('Hourly Forecast', style: TextStyle(fontSize: 20),),
                      HourlyForecastTable(),
                      const Text('Current Detail', style: TextStyle(fontSize: 20),),
                      CurrentDetailTable(),
                      const Text('Daily Forecast', style: TextStyle(fontSize: 20),),
                      DailyForecastTable(),
                      const Text('Air Quality', style: TextStyle(fontSize: 20),),
                      AirQualityTable(),
                      const Text('Allergy Outlook', style: TextStyle(fontSize: 20),),
                      AllergyOutlookTable(),
                      const Text('Sun & Moon', style: TextStyle(fontSize: 20),),
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
