// apiKey = 959741e13fc243c1830c92dafe286db9
//https://api.weatherapi.com/v1/forecast.json?key=7c087e009aa9405791065629241206&q=Ha%20noi&days=7
//key=7c087e009aa9405791065629241206


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_mobile_app_flutter/be/data/weather_location.dart';
import 'package:weather_mobile_app_flutter/configs/constants.dart';

abstract class Api {
  final String apiKey = Constants.apiKeyWeatherBit;
  Future<Map<String, dynamic>> getWeatherCurrent(double lat, double lon);
  Future<Map<String, dynamic>> getWeather24H(double lat, double lon);
  Future<Map<String, dynamic>> getWeather7Day(double lat, double lon);
  Future<Map<String, dynamic>> getAirQuality(double lat, double lon);
}
// Gọi api của Duy
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

// class WeatherApi {
//   String apiKey = '7c087e009aa9405791065629241206';
//   final String baseUrl = 'https://api.weatherapi.com/v1/current.json';
//   Future<Map<String, dynamic>> getWeatherCurrent(String location) async {
//     final url = '$baseUrl?key=$apiKey&q=$location';
//     final response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) { return jsonDecode(response.body); }
//     else { throw Exception('Không tải được dữ liệu thời tiết.'); } }
// }