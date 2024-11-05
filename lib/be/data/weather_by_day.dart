
class WeatherByDay {
  final DateTime time;
  final dynamic temperatureMax;
  final dynamic temperatureMin;
  final dynamic weatherCode;
  final dynamic icon;
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
    required this.icon,
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
      time: DateTime.parse(json['datetime'].replaceFirst(':', 'T')),
      temperatureMax: json['max_temp'],
      temperatureMin: json['min_temp'],
      weatherCode: json['weather']['description'],
      icon: json['weather']['code'],
      windDirection: json['wind_cdir'],
      windSpeed: json['wind_spd'],
      precipitationProbability: json['pop'],
      sunrise: DateTime.fromMillisecondsSinceEpoch(json['sunrise_ts'] * 1000),
      sunset: DateTime.fromMillisecondsSinceEpoch(json['sunset_ts'] * 1000),
      moonrise: DateTime.fromMillisecondsSinceEpoch(json['moonrise_ts'] * 1000),
      moonset: DateTime.fromMillisecondsSinceEpoch(json['moonset_ts'] * 1000),
    );
  }
}