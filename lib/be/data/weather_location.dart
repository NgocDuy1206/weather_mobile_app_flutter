class WeatherCurrent {
  final dynamic temperature;
  final dynamic temperatureApparent;
  final dynamic weatherCode;
  final dynamic precipitation;
  final dynamic windSpeed;
  final dynamic humidity;
  final dynamic uvIndex;
  final dynamic dewPoint;
  final dynamic pressure;

  WeatherCurrent({
    required this.temperature,
    required this.temperatureApparent,
    required this.weatherCode,
    required this.precipitation,
    required this.windSpeed,
    required this.humidity,
    required this.uvIndex,
    required this.dewPoint,
    required this.pressure,
  });

  factory WeatherCurrent.fromJson(Map<String, dynamic> json) {
    return WeatherCurrent(
        temperature: json[''],
        temperatureApparent: temperatureApparent,
        weatherCode: weatherCode,
        precipitation: precipitation,
        windSpeed: windSpeed,
        humidity: humidity,
        uvIndex: uvIndex,
        dewPoint: dewPoint,
        pressure: pressure
    )
  }
}

class WeatherByHour {
  final DateTime time;
  final dynamic temperature;
  final dynamic temperatureApparent;
  final dynamic weatherCode;
  final dynamic windDirection;
  final dynamic windSpeed;
  final dynamic precipitationProbability;

  WeatherByHour({
    required this.time,
    required this.temperature,
    required this.temperatureApparent,
    required this.weatherCode,
    required this.windDirection,
    required this.windSpeed,
    required this.precipitationProbability,
  });

  factory WeatherByHour.fromJson(Map<String, dynamic> json) {
    return WeatherByHour(
      time: DateTime.parse(json['timestamp_local']),
      temperature: json['temp'],
      temperatureApparent: json['app_temp'],
      weatherCode: json['weather']['description'],
      windDirection: json['wind_dir'],
      windSpeed: json['wind_spd'],
      precipitationProbability: json['pop'],
    );
  }
}

class WeatherByDay {
  final DateTime time;
  final dynamic temperatureMax;
  final dynamic temperatureMin;
  final dynamic weatherCode;
  final dynamic windDirection;
  final dynamic windSpeed;
  final dynamic precipitationProbability;
  final dynamic sunrise;
  final dynamic sunset;
  final dynamic moonrise;
  final dynamic moonset;

  WeatherByDay({
    required this.time,
    required this.temperatureMax,
    required this.temperatureMin,
    required this.weatherCode,
    required this.windDirection,
    required this.windSpeed,
    required this.precipitationProbability,
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
  });

  factory WeatherByDay.fromJson(Map<String, dynamic> json) {
    return WeatherByDay(
      time: DateTime.parse(json['datetime']),
      temperatureMax: json['max_tmp'],
      temperatureMin: json['min_tmp'],
      weatherCode: json['weather']['description'],
      windDirection: json['wind_dir'],
      windSpeed: json['wind_spd'],
      precipitationProbability: json['pop'],
      sunrise: DateTime.fromMicrosecondsSinceEpoch(json['sunrise_ts']),
      sunset: DateTime.fromMicrosecondsSinceEpoch(json['sunset_ts']),
      moonrise: DateTime.fromMicrosecondsSinceEpoch(json['moonrise_ts']),
      moonset: DateTime.fromMicrosecondsSinceEpoch(json['moonset_ts']),
    );
  }
}

class WeatherLocation {
  final String locationName;
  final double latitude;
  final double longitude;
  final List<WeatherByHour> hourList;
  final List<WeatherByDay> dayList;
  final WeatherCurrent current;

  WeatherLocation({
    required this.locationName,
    required this.latitude,
    required this.longitude,
    required this.hourList,
    required this.dayList,
    required this.current,
  });

  factory WeatherLocation.fromJson(
      double latitude,
      double longitude,
      String apiKey,
      Map<String, dynamic> current,
      Map<String, dynamic> hourly,
      Map<String, dynamic> daily) {
    // chuyển sang list
    var hourList = hourly['data'] as List;
    var dayList = daily['data'] as List;
    // tạo đối tượng
    List<WeatherByHour> listByHour = hourList.map((json) {
      return WeatherByHour.fromJson(json);
    }).toList();
    List<WeatherByDay> listByDay = dayList.map((json) {
      return WeatherByDay.fromJson(json);
    }).toList();
    return WeatherLocation(
        locationName: hourly['city_name'],
        latitude: latitude,
        longitude: longitude,
        hourList: listByHour,
        dayList: listByDay);
  }
}
