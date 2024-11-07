// apiKey = 959741e13fc243c1830c92dafe286db9

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_mobile_app_flutter/be/data/weather_location.dart';

abstract class Api {
  final apiKey = '959741e13fc243c1830c92dafe286db9';
  Future<Map<String, dynamic>> getWeatherCurrent(double lat, double lon);
  Future<Map<String, dynamic>> getWeather24H(double lat, double lon);
  Future<Map<String, dynamic>> getWeather7Day(double lat, double lon);
  Future<Map<String, dynamic>> getAirQuality(double lat, double lon);
}
class GetApi extends Api{
  Future<Map<String, dynamic>> getWeatherCurrent(double lat, double lon) async {
    final url = 'https://api.weatherbit.io/v2.0/current?'
        '&lat=$lat&lon=$lon'
        '&key=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('không tải được dữ liệu weather current');
    }
  }
  Future<Map<String, dynamic>> getWeather24H(double lat, double lon) async {
    final url = 'http://api.weatherbit.io/v2.0/forecast/hourly?'
        '&lat=$lat&lon=$lon'
        '&key=$apiKey'
        '&hours=48';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('không tải được dữ liệu 24H');
    }
  }

  Future<Map<String, dynamic>> getWeather7Day(double lat, double lon) async {
    final url = 'http://api.weatherbit.io/v2.0/forecast/daily?'
        '&lat=$lat&lon=$lon'
        '&key=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('không tải được dữ liệu 7Day');
    }
  }

  Future<Map<String, dynamic>> getAirQuality(double lat, double lon) async {
    final url = 'https://api.weatherbit.io/v2.0/forecast/airquality?'
        '&lat=$lat&lon=$lon'
        '&key=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('không tải được dữ liệu 7Day');
    }
  }

  Future<WeatherLocation> getWeatherData(double lat, double lon) async {
    Map<String, dynamic> current = await getWeatherCurrent(lat, lon);
    Map<String, dynamic> hourly = await getWeather24H(lat, lon);
    Map<String, dynamic> daily = await getWeather7Day(lat, lon);
    Map<String, dynamic> airQ = await getAirQuality(lat, lon);

    return WeatherLocation.fromJson(lat, lon, apiKey, current['data'][0], hourly, daily, airQ);
  }
}