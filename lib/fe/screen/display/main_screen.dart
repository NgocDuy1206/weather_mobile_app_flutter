
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:weather_mobile_app_flutter/configs/constants.dart';
import 'package:weather_mobile_app_flutter/fe/components/destination.dart';
import 'package:weather_mobile_app_flutter/fe/screen/display/forecast_screen.dart';
import 'package:weather_mobile_app_flutter/fe/screen/display/radar_screen.dart';
import 'package:weather_mobile_app_flutter/fe/screen/display/today_screen.dart';
import 'package:weather_mobile_app_flutter/be/state_management/Manager.dart';

class MainScreen extends StatefulWidget {

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  List<Widget> tabBottomNavigation = [Today(), Forecast(), Radar()];

  @override
  Widget build(BuildContext context) {
    InforDevice.WIDTH = MediaQuery.of(context).size.width;
    InforDevice.HEIGHT = MediaQuery.of(context).size.height;
    var tab = Provider.of<BottomNagivation>(context);
    return Scaffold(

      body: tabBottomNavigation[tab.selectedTab],
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem> [
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/icon/today.png')),
              label: 'TODAY',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/icon/forecast.png')),
              label: 'FORECAST',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/icon/radar.png')),
              label: 'RADAR',
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
    );
  }
}