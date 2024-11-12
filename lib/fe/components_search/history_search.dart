import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  // Lưu danh sách vị trí tìm kiếm vào SharedPreferences
  static Future<void> saveSearchHistory(List<String> history) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('search_history', history);
  }

  // Đọc danh sách vị trí tìm kiếm từ SharedPreferences
  static Future<List<String>> getSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('search_history') ?? [];
  }
}
