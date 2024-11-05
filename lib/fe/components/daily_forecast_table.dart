import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:weather_mobile_app_flutter/be/data/weather_by_day.dart';
import 'package:weather_mobile_app_flutter/be/state_management/Manager.dart';
import 'package:weather_mobile_app_flutter/configs/constants.dart';
import 'package:weather_mobile_app_flutter/configs/utils.dart';
import 'package:weather_mobile_app_flutter/fe/components/button_see_more.dart';


class DailyForecastTable extends StatelessWidget {
  bool showSeeMoreDetail;
  DailyForecastTable({this.showSeeMoreDetail = true});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: (InforDevice.WIDTH - 40),

      margin: EdgeInsets.only(top: 10, bottom: 25),
      padding: EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: MyColors.GRAY,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Center(
          child: Column(
            children: [
              DailyTable(showSeeMoreDetail: showSeeMoreDetail),
              if (showSeeMoreDetail == true) SeeMoreDetail(),
            ],
          )),
    );
  }
}

class DailyTable extends StatelessWidget {
  bool showSeeMoreDetail;
  DailyTable({this.showSeeMoreDetail = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: InforDevice.WIDTH - 80,
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: showSeeMoreDetail? 4: 8,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: ColumnDailyForecast(index: index,),
          );
        },
      ),
    );
  }
}

class ColumnDailyForecast extends StatelessWidget {
  int index;
  ColumnDailyForecast({this.index = 0});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<WeatherManager>(context);
    WeatherByDay daily = provider.weatherLocation!.dayList[index];
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          Utils.getDay(daily.time),
          style: TextStyle(fontSize: 20),
        ),
        Text(
          Utils.getWeekDay(daily.time),
          style: TextStyle(fontSize: 20),
        ),
        Image.asset(MyIconWeather.getIconWeather(daily.icon, daily.time),scale: 2.75,),
        Text(daily.temperatureMax.toString() + '${Constants.DEGREES}',
          style: TextStyle(fontSize: 20),),
        const SizedBox(
          height: 35,
        ),
        Text(daily.temperatureMin.toString() + '${Constants.DEGREES}',
          style: TextStyle(fontSize: 20),),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon/rainy_small.png',
              scale: 4.0,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(daily.precipitationProbability.toString() + '%',
              style: TextStyle(fontSize: 15),),
          ],
        ),
      ],
    );
  }
}

