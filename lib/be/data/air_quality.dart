class AirQuality {
  final DateTime time;
  final dynamic airQuality;
  final dynamic o3;
  final dynamic so2;
  final dynamic no2;
  final dynamic co;
  final dynamic pn25;

  AirQuality({
    required this.time,
    required this.airQuality,
    required this.o3,
    required this.so2,
    required this.no2,
    required this.co,
    required this.pn25,
  });

  factory AirQuality.fromJson(Map<String, dynamic> json) {
    return AirQuality(
        time: DateTime.parse(json['timestamp_local']),
        airQuality: json['aqi'],
        o3: json['o3'],
        so2: json['so2'],
        no2: json['no2'],
        co: json['co'],
        pn25: json['pm25']
    );
  }
}
