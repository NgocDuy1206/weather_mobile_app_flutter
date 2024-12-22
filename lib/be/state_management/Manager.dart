import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_mobile_app_flutter/be/api/api.dart';
import 'package:weather_mobile_app_flutter/be/data/weather_location.dart';



class WeatherManager with ChangeNotifier {
  WeatherLocation? weatherLocation;
  bool loading = true;
  double lat = 21.0285;
  double lon = 105.8542;
  String? currentSelected;  // Thêm biến để theo dõi vị trí hiện tại

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
  void updateLocation(double latitude, double longitude, String locationName) {
    lat = latitude;
    lon = longitude;
    currentSelected = locationName; // Cập nhật tên vị trí hiện tại
    loadingData(); // Tải lại dữ liệu thời tiết sau khi cập nhật vị trí
    notifyListeners();
  }
}

class BottomNagivation with ChangeNotifier {
  int selectedTab;
  BottomNagivation({this.selectedTab = 0});

  void updateTab(int index) {
    selectedTab = index;
    notifyListeners();
  }
}

class MapManager with ChangeNotifier {
  String type = 'clouds_new';

  void updateMap(String type_new) {
    type = type_new;
    notifyListeners();
  }
}


