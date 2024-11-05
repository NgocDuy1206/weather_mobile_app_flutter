class WeatherCurrent {
  final dynamic temperature;
  final dynamic temperatureApparent;
  final dynamic weatherCode;
  final dynamic icon;
  final dynamic precipitation;
  final dynamic windSpeed;
  final dynamic humidity;
  final dynamic uvIndex;
  final dynamic visibility;
  final dynamic dewPoint;
  final dynamic pressure;

  WeatherCurrent({
    required this.temperature,
    required this.temperatureApparent,
    required this.weatherCode,
    required this.icon,
    required this.precipitation,
    required this.windSpeed,
    required this.humidity,
    required this.uvIndex,
    required this.visibility,
    required this.dewPoint,
    required this.pressure,
  });

  factory WeatherCurrent.fromJson(Map<String, dynamic> json) {
    return WeatherCurrent(
        temperature: json['temp'],
        temperatureApparent: json['app_temp'],
        weatherCode: json['weather']['description'],
        icon: json['weather']['code'],
        precipitation: json['precip'],
        windSpeed: json['wind_spd'],
        humidity: json['rh'],
        uvIndex: json['uv'],
        visibility: json['vis'],
        dewPoint: json['dewpt'],
        pressure: json['pres']
    );
  }
}
