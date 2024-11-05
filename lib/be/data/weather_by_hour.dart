
class WeatherByHour {
  final DateTime time;
  final dynamic temperature;
  final dynamic temperatureApparent;
  final dynamic weatherCode;
  final dynamic icon;
  final dynamic windDirection;
  final dynamic windSpeed;
  final dynamic precipitationProbability;

  WeatherByHour({
    required this.time,
    required this.temperature,
    required this.temperatureApparent,
    required this.weatherCode,
    required this.icon,
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
      icon: json['weather']['code'],
      windDirection: json['wind_cdir'],
      windSpeed: json['wind_spd'],
      precipitationProbability: json['pop'],
    );
  }
}