// this file contain const variable
import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Constants {
  static const String apiKeyWeatherBit = '3a4a69cd4cc0489f9a2a7f5f245abc02';
  static const String apiKeyOpenWeatherMap = '9c77ab59ab5de55a944a4a92bb9f35cc';
  static const String NAME_APP = "1WEATHER";
  static const String DEGREES = '\u00B0';
}
class MyColors {
  static const Color GRAY = Color(0x9B795151);
  static const Color BLUE = Color(0xFF3258E8);
  static const Color YELLOW = Color(0xFFECCD07);
  static const Color YELLOW1 = Color(0xFFE3CB74);
  static const Color GREEN = Color(0xFF1BDC09);
  static const Color GREEN1 = Color(0xFF7AC96E);
  static const Color RED = Color(0xFFE34242);
  static const Color RED1 = Color(0xFFE06A6A);
  static const Color WHITE = Color(0xFFFFFFFF);
  static const Color BLACK = Color(0xFF1A1717);


  // màu sắc cho tình trạng không khí
  static const Color Good = Color(0xFF1BDC09);
  static const Color Moderate = Color(0xFF7AC96E);
  static const Color Unhealthy_fsg = Color(0xFFE3CB74);
  static const Color Unhealthy = Color(0xFFECCD07);
  static const Color Very_unhealthy = Color(0xFFE06A6A);
  static const Color Hazardous = Color(0xFFE34242);

  // màu sắc của cột thời tiết
  static const Color beginColorColumn = Color(0xFFE8C723);
  static const Color endColorColumn = Color(0xFFFFA500);
  static const Color vien = Color(0xFF2F2C2C);
  static const Color background_table = Color(0xA15272D7);
  static const Color background_theme = Color(0xC2FFFFFF);
  static const Color background_forecast = Color(0xE56D0ABE);


}
class InforDevice {
  static double WIDTH = 0.0;
  static double HEIGHT = 0.0;
}
