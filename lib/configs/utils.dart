import 'dart:ui';

import 'package:weather_mobile_app_flutter/be/data/air_quality.dart';
import 'package:weather_mobile_app_flutter/configs/constants.dart';

import '../be/state_management/setting_manager.dart';
import 'language.dart';

class MyIconWeather {
  static String getIconWeather(dynamic code, DateTime time) {
    String tail = '_am';
    if (time.hour > 18) tail = '_pm';
    return 'assets/icon/icon_weather/${code.toString() + tail}.png';
  }
}

class Utils {
  static String getWeekDay(DateTime time) {
    int t = time.weekday;
    switch (t) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return 'Mon';
    }
  }

  static String getMonth(DateTime time) {
    int t = time.month;
    switch (t) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return 'Jan';
    }
  }

  static String getMonthDay(DateTime time) {
    return getMonth(time) + ' ' + getDay(time);
  }

  static String getHourMinute(DateTime time) {
    return (time.hour < 10)
        ? '0' + time.hour.toString() + ':00'
        : time.hour.toString() + ':00';
  }

  static String getHour12H(DateTime time) {
    int t = time.hour;
    String x = (time.hour % 12).toString() + ':' + getMinute(time.minute);
    if (t >= 12) return x + ' PM';
    return x + ' AM';
  }
  
  static String getMinute(int minute) {
    return (minute < 10)? '0' + minute.toString(): minute.toString();
  }

  static String getDay(DateTime time) {
    if (time.day < 10)
      return '0' + time.day.toString();
    else
      return time.day.toString();
  }

  static String getEvaluateAirQ(dynamic x) {
    if (x >= 0 && x < 50) {
      return 'Good';
    } else if (x >= 50 && x < 100) {
      return 'Moderate';
    } else if (x >= 100 && x < 150) {
      return 'Unhealthy for Sensitive Groups';
    } else if (x >= 150 && x < 200) {
      return 'Unhealthy';
    } else if (x >= 200 && x < 300) {
      return 'Very Unhealthy';
    } else if (x > 300) {
      return 'Hazardous';
    } else return 'nhỏ hơn 0';
  }

  static String getNameMap(String type) {
    switch(type) {
      case 'clouds_new': return 'Cloud Map';
      case 'precipitation_new': return 'Precipitation Map';
      case 'wind_new': return 'Wind Map';
      case 'pressure_new': return 'Pressure Map';
      case 'temp_new': return 'Temperature Map';
      default: return 'Cloud Map';
    }
  }


  static String getText(String codeName) {
    if (SettingManager.language == 'english') {
      return Language.english[codeName];
    } else if (SettingManager.language == 'vietnam') {
      return Language.vietnam[codeName];
    } else throw Exception('app không hỗ trợ ngôn ngữ này');
  }

  static String getTemp(dynamic number, String unit) {
    number = number.toDouble();
    if (unit == 'C') {
      return number.toString() + ' ${Constants.DEGREES}';
    } return (number * 9 / 5 + 32).toStringAsFixed(1) + ' ${Constants.DEGREES}';
  }

  static String getSpeed(dynamic number, String unit) {
    number = number.toDouble();
    if (unit == 'mph') {
      return (number * 2.23694).toStringAsFixed(1)+ ' mph';
    } else if (unit == 'km/h') {
      return (number * 3.6).toStringAsFixed(1) + ' km/h';
    } else return number.toStringAsFixed(1) + ' m/s';
  }

  static String getDistance(dynamic number, String unit) {
    number = number.toDouble();
    if (unit == 'm') {
      return (number * 1000 ).toString() + ' m';
    } return (number).toStringAsFixed(1) + ' km';
  }

  static String getPress(dynamic number, String unit) {
    number = number.toDouble();
    if (unit == 'kPa') {
      return (number / 10 ).toStringAsFixed(1) + ' kPa';
    } return (number / 101.325 / 10).toStringAsFixed(1) + ' atm';
  }

  static dynamic getValueAQI(String name, AirQuality aqi) {
    name = name.toLowerCase();
    switch (name) {
      case 'pm10': return aqi.pm10;
      case 'pm2.5': return aqi.pm25;
      case 'co': return aqi.pm10 * 24.45 / 28.01;
      case 'so2': return aqi.pm25 * 24.45 / 64.07;
      case 'o3': return aqi.pm10 * 24.45 / 48;
      case 'no2': return aqi.pm25 * 24.45 / 46.01;
      default : return aqi.airQuality;
    }
  }

  static String getUnitAQI(String name) {
    name = name.toLowerCase();
    switch (name) {
      case 'pm10': return 'µg/m³';
      case 'pm2.5': return 'µg/m³';
      case 'co': return 'ppb';
      case 'so2': return 'ppb';
      case 'o3': return 'ppb';
      case 'no2': return 'ppb';
      default : return 'ppb';
    }
  }

  static Color getColorAQI(dynamic x) {
    if (x >= 0 && x < 50) {
      return MyColors.Good;
    } else if (x >= 50 && x < 100) {
      return MyColors.Moderate;
    } else if (x >= 100 && x < 150) {
      return MyColors.Unhealthy_fsg;
    } else if (x >= 150 && x < 200) {
      return MyColors.Unhealthy;
    } else if (x >= 200 && x < 300) {
      return MyColors.Very_unhealthy;
    } else if (x > 300) {
      return MyColors.Hazardous;
    } else return MyColors.Good;
  }

  static String getBackGround() {
    DateTime now = DateTime.now();
    dynamic hour = now.hour;
    if (hour < 18) {
      return 'assets/image/background_light2.jpg';
    } return 'assets/image/background_night2.jpg';
  }

}

