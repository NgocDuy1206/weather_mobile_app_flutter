import 'package:flutter/cupertino.dart';
import 'package:weather_mobile_app_flutter/fe/components/hourly_forecast_table.dart';
import 'package:weather_mobile_app_flutter/fe/components/weather_card.dart';

class HourlyTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24 * 70 + 300,
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
          SliverToBoxAdapter(
            child: SizedBox(height: 150,),
          )
        ],
      ),
    );
  }
}