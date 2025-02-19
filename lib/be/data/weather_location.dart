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

  // Thêm getter cho mô tả thời tiết và nhiệt độ hiện tại
  String get currentWeatherDescription => current.weatherCode; // Lấy mô tả thời tiết từ thuộc tính 'weatherCode'
  double get currentTemperature => current.temperature.toDouble(); // Chuyển đổi nhiệt độ sang double

  double getTempMaxByHour() {
    double tempMax = 0;
    for (var x in hourList) {
      tempMax = (tempMax > x.temperature) ? tempMax : x.temperature.toDouble();
    }
    return tempMax;
  }

  double getTempMinByHour() {
    double tempMin = 100;
    for (var x in hourList) {
      tempMin = (tempMin < x.temperature) ? tempMin : x.temperature.toDouble();
    }
    return tempMin;
  }

  double getTempMaxByDay() {
    double temMax = 0;
    for (var x in dayList) {
      temMax = (temMax > x.temperatureMax) ? temMax : x.temperatureMax.toDouble();
    }
    return temMax;
  }

  double getTempMinByDay() {
    double tempMin = 100;
    for (var x in dayList) {
      tempMin = (tempMin < x.temperatureMin) ? tempMin : x.temperatureMin.toDouble();
    }
    return tempMin;
  }
}
