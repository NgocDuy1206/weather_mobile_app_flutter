


import 'package:weather_mobile_app_flutter/be/data/air_quality.dart';
import 'package:weather_mobile_app_flutter/be/data/weather_by_day.dart';
import 'package:weather_mobile_app_flutter/be/data/weather_by_hour.dart';
import 'package:weather_mobile_app_flutter/be/data/weather_current.dart';

class WeatherLocation {
  final String locationName;
  final double latitude;
  final double longitude;
  final List<WeatherByHour> hourList;
  final List<WeatherByDay> dayList;
  final WeatherCurrent current;
  final List<AirQuality> airQualityList;

  WeatherLocation({
    required this.locationName,
    required this.latitude,
    required this.longitude,
    required this.hourList,
    required this.dayList,
    required this.current,
    required this.airQualityList,
  });

  factory WeatherLocation.fromJson(
      double latitude,
      double longitude,
      String apiKey,
      Map<String, dynamic> current,
      Map<String, dynamic> hourly,
      Map<String, dynamic> daily,
      Map<String, dynamic> airQ) {
    // chuyển sang list
    var hourList = hourly['data'] as List;
    var dayList = daily['data'] as List;
    var airList = airQ['data'] as List;
    // tạo đối tượng
    List<WeatherByHour> listByHour = hourList.map((json) {
      return WeatherByHour.fromJson(json);
    }).toList();
    List<WeatherByDay> listByDay = dayList.map((json) {
      return WeatherByDay.fromJson(json);
    }).toList();
    List<AirQuality> listAir = airList.map((json) {
      return AirQuality.fromJson(json);
    }).toList();
    return WeatherLocation(
        locationName: hourly['city_name'],
        latitude: latitude,
        longitude: longitude,
        current: WeatherCurrent.fromJson(current),
        hourList: listByHour,
        dayList: listByDay,
        airQualityList: listAir,

    );
  }
}