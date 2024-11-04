import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:weather_mobile_app_flutter/be/data/weather_by_hour.dart';
import 'package:weather_mobile_app_flutter/be/state_management/Manager.dart';
import 'package:weather_mobile_app_flutter/configs/constants.dart';
import 'package:weather_mobile_app_flutter/fe/components/button_see_more.dart';


class HourlyForecastTable extends StatelessWidget {
  bool showSeeMoreDetail;

  HourlyForecastTable({this.showSeeMoreDetail = true});
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
          HourlyTable(showSeeMoreDetail: showSeeMoreDetail),
          if(showSeeMoreDetail == true) SeeMoreDetail(),
        ],
      )),
    );
  }
}

class HourlyTable extends StatelessWidget {
  bool showSeeMoreDetail;
  HourlyTable({this.showSeeMoreDetail = true});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: InforDevice.WIDTH - 80,
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: showSeeMoreDetail? 4: 24,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: ColumnHourlyForecast(index: index)
          );
        },
      ),
    );
  }
}

class ColumnHourlyForecast extends StatelessWidget {
  int index;
  ColumnHourlyForecast({this.index = 0});
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<WeatherManager>(context);
    WeatherByHour hourWeather = provider.weatherLocation!.hourList[index];
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          hourWeather.time.hour.toString() + ":00",
          style: TextStyle(fontSize: 20),
        ),
        Image.asset('assets/icon/sunny_and_cloud.png'),
        const SizedBox(
          height: 35,
        ),
        Text(hourWeather.temperature.toString()+'${Constants.DEGREES}', style: TextStyle(fontSize: 20),),
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
            Text(hourWeather.precipitationProbability.toString() +'%',
              style: TextStyle(fontSize: 15),),
          ],
        ),
      ],
    );
  }
}
