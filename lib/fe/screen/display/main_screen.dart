
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:weather_mobile_app_flutter/configs/constants.dart';
import 'package:weather_mobile_app_flutter/fe/screen/display/forecast_screen.dart';
import 'package:weather_mobile_app_flutter/fe/screen/display/radar_screen.dart';
import 'package:weather_mobile_app_flutter/fe/screen/display/today_screen.dart';
import 'package:weather_mobile_app_flutter/be/state_management/Manager.dart';


import '../../../configs/utils.dart';

class MainScreen extends StatefulWidget {

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  List<Widget> tabBottomNavigation = [Today(), Forecast(), Radar()];

  @override
  Widget build(BuildContext context) {
    var tab = Provider.of<BottomNagivation>(context);
    return Scaffold(
      body: tabBottomNavigation[tab.selectedTab],
      bottomNavigationBar: Container(
        height: 120,
        child: BottomNavigationBar(
            items: <BottomNavigationBarItem> [
              BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage('assets/icon/today.png')),
                label: Utils.getText('today'),
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/icon/forecast.png')),
                label: Utils.getText('forecast'),
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/icon/radar.png')),
                label: Utils.getText('radar'),
              ),
            ],
          onTap: (int index){
              tab.updateTab(index);
          },

          showSelectedLabels: true,
          currentIndex: tab.selectedTab,
          selectedItemColor: MyColors.BLUE,
          unselectedItemColor: MyColors.GRAY,
          unselectedIconTheme: const IconThemeData(
            color: Colors.grey,
            size: 50
          ),
          selectedIconTheme: const IconThemeData(
            size: 50,
          ),

        ),
      ),
    );
  }
}