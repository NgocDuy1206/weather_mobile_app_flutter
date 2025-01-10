import 'package:flutter/cupertino.dart';
import 'package:weather_mobile_app_flutter/configs/constants.dart';
import 'package:weather_mobile_app_flutter/fe/components/hourly_forecast_table.dart';
import 'package:weather_mobile_app_flutter/fe/components/weather_card.dart';

class HourlyTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      height: InforDevice.HEIGHT,
      color: MyColors.background_theme,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: HourlyForecastTable(showSeeMoreDetail: false,),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Column(
                  children: [
                    WeatherCard(index: index,),
                    SizedBox(height: 10,),
                  ],
                );
              },
              childCount: 24, // Số lượng phần tử
            ),
          ),
          
        ],
      ),
    );
  }
}