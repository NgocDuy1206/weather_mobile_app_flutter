import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_mobile_app_flutter/configs/constants.dart';
import 'package:weather_mobile_app_flutter/fe/components/destination.dart';
import 'package:weather_mobile_app_flutter/fe/screen/display/today_screen.dart';

class Forecast extends StatefulWidget {
  @override
  State<Forecast> createState() => _Forecast();
}

class _Forecast extends State<Forecast> {
  bool tab = true;

  void goTo() {
    setState(() {
      tab = !tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 0,
            pinned: true,
            floating: true,
            expandedHeight: 110,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: CustomAppBar(),
            ),
          ),
          SliverToBoxAdapter()
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListDestination(),
          const SizedBox(
            height: 10,
          ),
          ForecastTab(),
        ],
      ),
    );
  }
}

class ForecastTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: InforDevice.WIDTH - 100,
      height: 30,
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1.0
        )
      ),
      child: TabBar(
          indicator: BoxDecoration(
            color: MyColors.BLUE,
            borderRadius: BorderRadius.circular(10),
          ),
          labelColor: MyColors.WHITE,
          unselectedLabelColor: MyColors.BLACK,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: const [
            Tab(
              text: 'Hourly',
            ),
            Tab(
              text: 'Daily',
            ),
          ]),
    );
  }
}
