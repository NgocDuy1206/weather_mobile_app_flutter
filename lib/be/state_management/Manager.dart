import 'package:flutter/cupertino.dart';
import 'package:weather_mobile_app_flutter/be/api/api.dart';
import 'package:weather_mobile_app_flutter/be/data/weather_location.dart';



class WeatherManager with ChangeNotifier {
  WeatherLocation? weatherLocation;
  bool loading = true;
  double lat = 21.0285;
  double lon = 105.8542;

  WeatherManager() {
    loadingData();
  }

  Future<void> loadingData() async {
    loading = true;
    notifyListeners();
    weatherLocation = await GetApi().getWeatherData(lat, lon);
    loading = false;
    notifyListeners();
  }
}