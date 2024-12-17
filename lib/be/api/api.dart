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
  Future<List<Map<String, String>>> searchLocation(String query); // Hàm tìm kiếm vị trí
}

class GetApi extends Api {
  @override
  Future<Map<String, dynamic>> getWeatherCurrent(double lat, double lon) async {
    final url = 'https://api.weatherbit.io/v2.0/current?lat=$lat&lon=$lon&key=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('không tải được dữ liệu weather current');
    }
  }

  @override
  Future<Map<String, dynamic>> getWeather24H(double lat, double lon) async {
    final url = 'http://api.weatherbit.io/v2.0/forecast/hourly?lat=$lat&lon=$lon&key=$apiKey&hours=48';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('không tải được dữ liệu 24H');
    }
  }

  @override
  Future<Map<String, dynamic>> getWeather7Day(double lat, double lon) async {
    final url = 'http://api.weatherbit.io/v2.0/forecast/daily?lat=$lat&lon=$lon&key=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('không tải được dữ liệu 7Day');
    }
  }

  @override
  Future<Map<String, dynamic>> getAirQuality(double lat, double lon) async {
    final url = 'https://api.weatherbit.io/v2.0/forecast/airquality?lat=$lat&lon=$lon&key=$apiKey';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('không tải được dữ liệu không khí');
    }
  }

  @override
  Future<List<Map<String, String>>> searchLocation(String query) async {
    // API endpoint to get search suggestions based on query
    final url = 'http://api.weatherapi.com/v1/search.json?key=af22b90d53f643f7a92162857241712&q=$query';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;

      // Extract location names from the response data
      List<Map<String, String>> locations = data.map((location) => {
        'name': location['name'] as String,
        'region': location['region'] as String? ?? '',  // Handle missing region
        'country': location['country'] as String
      }).toList();

      return locations;
    } else {
      throw Exception('Unable to fetch location suggestions');
    }
  }


  // Future<List<String>> searchLocation(String query) async {
  //   final url = 'https://restcountries.com/v3.1/all';
  //   final response = await http.get(Uri.parse(url));
  //
  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     List<String> locations = [];
  //
  //     for (var country in data) {
  //       if (country['capital'] != null && country['capital'].toString().toLowerCase().contains(query.toLowerCase())) {
  //         locations.add(country['capital'][0]); // Adding capital city to the list
  //       }
  //     }
  //
  //     return locations;
  //   } else {
  //     throw Exception('Unable to fetch data');
  //   }
  // }


  Future<WeatherLocation> getWeatherData(double lat, double lon) async {
    Map<String, dynamic> current = await getWeatherCurrent(lat, lon);
    Map<String, dynamic> hourly = await getWeather24H(lat, lon);
    Map<String, dynamic> daily = await getWeather7Day(lat, lon);
    Map<String, dynamic> airQ = await getAirQuality(lat, lon);

    return WeatherLocation.fromJson(lat, lon, apiKey, current['data'][0], hourly, daily, airQ);
  }
}

