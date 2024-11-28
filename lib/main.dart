import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_mobile_app_flutter/be/state_management/Manager.dart';
import 'package:weather_mobile_app_flutter/be/state_management/animation.dart';
import 'package:weather_mobile_app_flutter/be/state_management/setting_manager.dart';
import 'package:weather_mobile_app_flutter/fe/components/loading.dart';
import 'package:weather_mobile_app_flutter/fe/screen/display/main_screen.dart';

import 'configs/constants.dart';



void main() {

  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => WeatherManager()),
          ChangeNotifierProvider(create: (context) => BottomNagivation()),
          ChangeNotifierProvider(create: (context) => MapManager()),
          ChangeNotifierProvider(create: (context) => SettingManager()),
          ChangeNotifierProvider(create: (context) => AnimatedProvider())
        ],
      child: WeatherApp(),
    )
  );
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});


  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<WeatherManager>(context);
    return MaterialApp(
      home: Scaffold(
        body: provider.loading ? Loading(): MainScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

