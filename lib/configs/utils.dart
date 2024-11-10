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
}

