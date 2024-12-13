import 'package:flutter/material.dart';
import 'package:weather_mobile_app_flutter/configs/utils.dart';
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

import '../setting/display_search_manageLocation/search_screen.dart';

class Today extends StatefulWidget {
  const Today({super.key});

  @override
  State<Today> createState() => _TodayState();
}

class _TodayState extends State<Today> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        'assets/image/background_light2.jpg',
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
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
            expandedHeight: 150,
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
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Color(0xFF1A0A1A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (BuildContext context) {
                        return SearchScreenModal();
                      },
                    );
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
                    color: MyColors.background_theme,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      Text(Utils.getText('hourly_forecast'), style: TextStyle(fontSize: 20),),
                      HourlyForecastTable(),
                      Text(Utils.getText('current_details'), style: TextStyle(fontSize: 20),),
                      CurrentDetailTable(),
                      Text(Utils.getText('daily_forecast'), style: TextStyle(fontSize: 20),),
                      DailyForecastTable(),
                      Text(Utils.getText('air_quality'), style: TextStyle(fontSize: 20),),
                      AirQualityTable(),
                      Text(Utils.getText('allergy_outlook'), style: TextStyle(fontSize: 20),),
                      AllergyOutlookTable(),
                      Text(Utils.getText('sun_moon'), style: TextStyle(fontSize: 20),),
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
