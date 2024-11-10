import 'package:flutter/cupertino.dart';

class SettingManager with ChangeNotifier {
    static String language = 'english';

    void updateLanguage(String newLanguage) {
      if (language != newLanguage) {
        language = newLanguage;
        notifyListeners();
      }
    }
}