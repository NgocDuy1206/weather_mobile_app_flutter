import 'package:flutter/cupertino.dart';

class SettingManager with ChangeNotifier {
  static String language = 'english';
  String tempUnit = 'C';
  String spdUnit = 'mph';
  String distanceUnit = 'm';
  String pressUnit = 'kPa';

  // Thêm biến để lưu trạng thái theme
  String _theme = 'light'; // Mặc định là light theme
  String get theme => _theme;

  void updateLanguage(String newLanguage) {
    if (language != newLanguage) {
      language = newLanguage;
      notifyListeners();
    }
  }

  void updateTempUnit(String newTempUnit) {
    if (tempUnit != newTempUnit) {
      tempUnit = newTempUnit;
      notifyListeners();
    }
  }

  void updateSpdUnit(String newSpd) {
    if (spdUnit != newSpd) {
      spdUnit = newSpd;
      notifyListeners();
    }
  }

  void updateDistanceUnit(String newDisUnit) {
    if (distanceUnit != newDisUnit) {
      distanceUnit = newDisUnit;
      notifyListeners();
    }
  }

  void updatePressUnit(String newPressUnit) {
    if (pressUnit != newPressUnit) {
      pressUnit = newPressUnit;
      notifyListeners();
    }
  }

  // Thêm phương thức cập nhật theme
  void updateTheme(String newTheme) {
    if (_theme != newTheme) {
      _theme = newTheme;
      notifyListeners();
    }
  }
}
