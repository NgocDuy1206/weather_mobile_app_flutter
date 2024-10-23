import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_mobile_app_flutter/be/state_management/Manager.dart';
import 'package:weather_mobile_app_flutter/fe/screen/Screen1.dart';
import 'package:weather_mobile_app_flutter/fe/screen/main_screen.dart';
import 'fe/screen/HomeScreen.dart';
import 'fe/screen/Screen2.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
        create: (_) => Manager(),
        child: const WeatherApp(),
    )
  );
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      routes: {
        '/screen1': (context) => Screen1(),
        '/screen2': (context) => Screen2(),
        '/main_screen': (context) => MainScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}