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

  static String getDay(DateTime time) {
    if (time.day < 10)
      return '0' + time.day.toString();
    else
      return time.day.toString();
  }
}
// switch(code) {
//   case 200: return 'assets/icon/icon_weather/'
//   case 201: return 'assets/icon/icon_weather/'
//   case 202: return 'assets/icon/icon_weather/'
//   case 230: return 'assets/icon/icon_weather/'
//   case 231: return 'assets/icon/icon_weather/'
//   case 232: return 'assets/icon/icon_weather/'
//   case 233: return 'assets/icon/icon_weather/'
//   case 300: return 'assets/icon/icon_weather/'
//   case 301: return 'assets/icon/icon_weather/'
//   case 302: return 'assets/icon/icon_weather/'
//   case 500: return 'assets/icon/icon_weather/'
//   case 501: return 'assets/icon/icon_weather/'
//   case 502: return 'assets/icon/icon_weather/'
//   case 511: return 'assets/icon/icon_weather/'
//   case 520: return 'assets/icon/icon_weather/'
//   case 521: return 'assets/icon/icon_weather/'
//   case 522: return 'assets/icon/icon_weather/'
//   case 600: return 'assets/icon/icon_weather/'
//   case 601: return 'assets/icon/icon_weather/'
//   case 602: return 'assets/icon/icon_weather/'
//   case 610: return 'assets/icon/icon_weather/'
//   case 611: return 'assets/icon/icon_weather/'
//   case 612: return 'assets/icon/icon_weather/'
//   case 621: return 'assets/icon/icon_weather/'
//   case 622: return 'assets/icon/icon_weather/'
//   case 623: return 'assets/icon/icon_weather/'
//   case 700: return 'assets/icon/icon_weather/'
//   case 711: return 'assets/icon/icon_weather/'
//   case 721: return 'assets/icon/icon_weather/'
//   case 731: return 'assets/icon/icon_weather/'
//   case 741: return 'assets/icon/icon_weather/'
//   case 751: return 'assets/icon/icon_weather/'
//   case 800: return 'assets/icon/icon_weather/'
//   case 801: return 'assets/icon/icon_weather/'
//   case 802: return 'assets/icon/icon_weather/'
//   case 803: return 'assets/icon/icon_weather/'
//   case 804: return 'assets/icon/icon_weather/'
//   case 900: return 'assets/icon/icon_weather/'
//
// }
