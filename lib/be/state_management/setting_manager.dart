import 'package:flutter/cupertino.dart';

class SettingManager with ChangeNotifier {
    static String language = 'english';
    String tempUnit = 'C';
    String spdUnit = 'mph';
    String distanceUnit = 'm';
    String pressUnit = 'kPa';

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
}