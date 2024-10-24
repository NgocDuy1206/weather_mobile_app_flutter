
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:weather_mobile_app_flutter/configs/constants.dart';
import 'package:weather_mobile_app_flutter/fe/components/destination.dart';
import 'package:weather_mobile_app_flutter/fe/screen/display/forecast_screen.dart';
import 'package:weather_mobile_app_flutter/fe/screen/display/radar_screen.dart';
import 'package:weather_mobile_app_flutter/fe/screen/display/today_screen.dart';

class MainScreen extends StatefulWidget {

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedTab = 0;
  List<Widget> tabBottomNavigation = [Today(), Forecast(), Radar()];

  void onSelectedTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabBottomNavigation[_selectedTab],
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
            onSelectedTab(index);
        },

        showSelectedLabels: true,
        currentIndex: _selectedTab,
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