
import 'package:flutter/material.dart';
import 'package:weather_mobile_app_flutter/configs/constants.dart';
import 'package:weather_mobile_app_flutter/fe/components/destination.dart';

class MainScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text(
              Constants.NAME_APP,
            ),
            floating: true,
            pinned: false,
            snap: true,
            expandedHeight: 200,
            actions: [
              IconButton(
                  onPressed: (){},
                  icon: Image.asset('assets/icon/search.png')
              ),

              IconButton(
                  onPressed: () {
                  },
                  icon: Image.asset('assets/icon/menu.png'),
              ),

            ],
          ),
          SliverToBoxAdapter(
            child: Row(
              children: [
                Destination(),
                Text('hello')
              ],
            ),
          ),
        ],
      ),
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
        showSelectedLabels: true,
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