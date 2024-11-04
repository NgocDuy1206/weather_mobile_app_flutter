// apiKey = 959741e13fc243c1830c92dafe286db9

import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class Api {
  final apiKey = '959741e13fc243c1830c92dafe286db9';
  Future<Map<String, dynamic>> getWeather24H(double lat, double lon);
  Future<Map<String, dynamic>> getWeather7Day(double lat, double lon);

}
class GetApi extends Api{

  Future<Map<String, dynamic>> getWeather24H(double lat, double lon) async {
    final url = 'http://api.weatherbit.io/v2.0/forecast/hourly?'
        '&lat=$lat&lon=$lon'
        '&key=$apiKey';
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

  Future<Map<String, dynamic>> getWeatherData(double lat, double lon) async {
    Map<String, dynamic> hourly = await getWeather24H(lat, lon);
    Map<String, dynamic> daily = await getWeather24H(lat, lon);
  }
}